locals {
  git_repo_name           = "ansible-gcpartner-anthos-vsphere"
  ansible_execute_timeout = 1800
  unix_home               = var.bastion_user == "root" ? "/root" : "/home/${var.bastion_user}"
  vcenter_ip              = cidrhost(var.priv_cidr, 2)
}

resource "null_resource" "write_ssh_private_key" {
  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }

  provisioner "file" {
    content     = var.ssh_key.private_key
    destination = "${local.unix_home}/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = ["chmod 0400 $HOME/.ssh/id_rsa"]
  }
}

resource "null_resource" "install_ansible" {
  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }


  provisioner "remote-exec" {
    inline = [

      "BIN_PATH=$HOME/.local/bin",
      "if [ \"$(whoami)\" = \"root\" ]; then",
      "BIN_PATH=/usr/local/bin",
      "fi",
      "mkdir -p $HOME/bootstrap",
      "cd $HOME/bootstrap",
      "curl -LO https://bootstrap.pypa.io/pip/3.6/get-pip.py",
      "(which python3>/dev/null 2>&1) || (apt install python3 -y>/dev/null 2>&1) || (dnf install python3 -y>/dev/null 2>&1)",
      "python3 get-pip.py --no-warn-script-location",
      "$BIN_PATH/pip install virtualenv",
      "$BIN_PATH/virtualenv ansible",
      ". ansible/bin/activate",
      "pip -q install ansible netaddr",
      "echo '[defaults]' > $HOME/.ansible.cfg",
      "echo 'host_key_checking = False' >> $HOME/.ansible.cfg",
      "rm -f get-pip.py"
    ]
  }
}

resource "null_resource" "write_gcp_master_sa_key" {
  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p $HOME/bootstrap/gcp_keys"
    ]
  }

  provisioner "file" {
    content     = base64decode(var.gcp_master_sa_key)
    destination = "${local.unix_home}/bootstrap/gcp_keys/master_sa_key.json"
  }
}

resource "null_resource" "download_ansible_playbook" {
  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p $HOME/bootstrap",
      "cd  $HOME/bootstrap",
      "curl -LO ${var.ansible_url}",
      "tar -xf ${var.ansible_tar_ball}",
      "rm -rf ${var.ansible_tar_ball}",
      "mv ${local.git_repo_name}* ${local.git_repo_name}"
    ]
  }
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/templates/inventory.tmpl")
  vars = {
    pub_cidr       = var.pub_cidr
    priv_cidr      = var.priv_cidr
    cluster_name   = var.cluster_name
    username       = var.bastion_user
    esx_node_count = var.esx_node_count
    gcp_project_id = var.gcp_project_id
    home_path      = local.unix_home
    esx_passwords  = jsonencode(var.esx_passwords)
    pub_vlan_id    = var.pub_vlan_id
    priv_vlan_id   = var.priv_vlan_id
    vcenter_ip     = local.vcenter_ip
    object_store_bucket_name = var.object_store_bucket_name
    vcenter_iso_name         = var.vcenter_iso_name
    s3_url                   = var.s3_url
    s3_access_key            = var.s3_access_key
    s3_secret_key            = var.s3_secret_key
    object_store_api         = var.object_store_api
  }
}

resource "null_resource" "write_ansible_inventory_header" {
  depends_on = [
    null_resource.download_ansible_playbook
  ]

  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }

  provisioner "file" {
    content     = data.template_file.ansible_inventory.rendered
    destination = "${local.unix_home}/bootstrap/${local.git_repo_name}/inventory"
  }
}

resource "null_resource" "write_esx_nodes_to_ansible_inventory" {
  count = var.esx_node_count
  depends_on = [
    null_resource.write_ansible_inventory_header
  ]

  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sleep ${count.index + 1}",
      "echo '${var.esx_priv_ips[count.index]}' >> $HOME/bootstrap/${local.git_repo_name}/inventory"
    ]
  }
}

resource "null_resource" "execute_ansible" {
  connection {
    type        = "ssh"
    user        = var.bastion_user
    private_key = var.ssh_key.private_key
    host        = var.bastion_ip
  }
  depends_on = [
    null_resource.download_ansible_playbook,
    null_resource.write_esx_nodes_to_ansible_inventory,
    null_resource.install_ansible,
    null_resource.write_gcp_master_sa_key
  ]

  # INFO: run in while loop, 3 times
  # INFO: if exit code is non zero, run it again, max 3 times
  provisioner "remote-exec" {
    inline = [
      ". $HOME/bootstrap/ansible/bin/activate",
      "cd $HOME/bootstrap/${local.git_repo_name}",
      "start=3",
      "while [ $start -gt 0 ]",
      "do",
      "/usr/bin/timeout ${local.ansible_execute_timeout} ansible-playbook --extra-vars=\"ansible_python_interpreter=$(which python)\" -bi inventory site.yaml ",
      "if [ $? -eq 0 ]; then",
      "break",
      "fi",
      "start=$((start-1))",
      "done",
    ]
  }
}
