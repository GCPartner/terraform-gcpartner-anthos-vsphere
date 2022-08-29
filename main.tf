terraform {
  required_providers {
    pnap = {
      source = "phoenixnap/pnap"
    }
  }
}

provider "pnap" {
  client_id     = var.pnap_client_id
  client_secret = var.pnap_client_secret
}

resource "random_string" "ssh_unique" {
  length  = 5
  special = false
  upper   = false
}

locals {
  ssh_key_name = format("anthos-vsphere-%s", random_string.ssh_unique.result)
}

resource "tls_private_key" "ssh_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "cluster_private_key_pem" {
  content         = chomp(tls_private_key.ssh_key_pair.private_key_pem)
  filename        = pathexpand(format("~/.ssh/%s", local.ssh_key_name))
  file_permission = "0600"
}

module "PNAP_Infra" {
  source = "./modules/phoenixnap"
  count  = var.cloud == "PNAP" ? 1 : 0
  ssh_key = {
    private_key = chomp(tls_private_key.ssh_key_pair.private_key_pem)
    public_key  = chomp(tls_private_key.ssh_key_pair.public_key_openssh)
  }
  node_count           = var.node_count
  bastion_os           = var.bastion_os
  vsphere_os           = var.vsphere_os
  pnap_location        = var.pnap_location
  pnap_bastion_type    = var.pnap_bastion_type
  pnap_esxi_type       = var.pnap_esxi_type
  pnap_create_network  = var.pnap_create_network
  pnap_priv_network_id = var.pnap_priv_network_id
  pnap_pub_network_id  = var.pnap_pub_network_id
  vcenter_cluster_name = lower(var.vcenter_cluster_name)
}

locals {
  pnap_bastion_ip     = var.cloud == "PNAP" ? module.PNAP_Infra.0.bastion_ip : ""
  pnap_bastion_user   = var.cloud == "PNAP" ? module.PNAP_Infra.0.bastion_user : ""
  pnap_pub_vlan_id    = var.cloud == "PNAP" ? module.PNAP_Infra.0.pub_vlan_id : ""
  pnap_priv_vlan_id   = var.cloud == "PNAP" ? module.PNAP_Infra.0.priv_vlan_id : ""
  pnap_esxi_pub_ips   = var.cloud == "PNAP" ? module.PNAP_Infra.0.esxi_pub_ips : []
  pnap_esxi_priv_ips  = var.cloud == "PNAP" ? module.PNAP_Infra.0.esxi_priv_ips : []
  pnap_esxi_passwords = var.cloud == "PNAP" ? module.PNAP_Infra.0.esxi_passwords : []
  bastion_ip          = coalesce(local.pnap_bastion_ip)
  bastion_user        = coalesce(local.pnap_bastion_user)
  pub_vlan_id         = coalesce(local.pnap_pub_vlan_id)
  priv_vlan_id        = coalesce(local.pnap_priv_vlan_id)
  esxi_pub_ips        = coalescelist(local.pnap_esxi_pub_ips)
  esxi_priv_ips       = coalescelist(local.pnap_esxi_priv_ips)
  esxi_passwords      = coalescelist(local.pnap_esxi_passwords)
}

module "Ansible_Bootstrap" {
  depends_on = [
    module.PNAP_Infra
  ]
  source = "./modules/ansible-bootstrap"
  ssh_key = {
    private_key = chomp(tls_private_key.ssh_key_pair.private_key_pem)
    public_key  = chomp(tls_private_key.ssh_key_pair.public_key_openssh)
  }
  bastion_ip       = local.bastion_ip
  bastion_user     = local.bastion_user
  pub_vlan_id      = local.pub_vlan_id
  priv_vlan_id     = local.priv_vlan_id
  esxi_pub_ips     = local.esxi_pub_ips
  esxi_priv_ips    = local.esxi_priv_ips
  esxi_passwords   = local.esxi_passwords
  ansible_tar_ball = var.ansible_tar_ball
  ansible_url      = var.ansible_url
}
