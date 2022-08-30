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

resource "random_string" "unique_chars" {
  length  = 5
  special = false
  upper   = false
}

locals {
  ssh_key_name = format("anthos-vsphere-%s", random_string.unique_chars.result)
  cluster_name = lower(format("%s-%s", var.vcenter_cluster_name, random_string.unique_chars.result))
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

module "GCP_Auth" {
  source         = "./modules/google-cloud-platform"
  cluster_name   = local.cluster_name
  gcp_project_id = var.gcp_project_id
}

module "PNAP_Infra" {
  source = "./modules/phoenixnap"
  count  = var.cloud == "PNAP" ? 1 : 0
  ssh_key = {
    private_key = chomp(tls_private_key.ssh_key_pair.private_key_pem)
    public_key  = chomp(tls_private_key.ssh_key_pair.public_key_openssh)
  }
  esx_node_count       = var.esx_node_count
  bastion_os           = var.bastion_os
  vsphere_os           = var.vsphere_os
  pnap_location        = var.pnap_location
  pnap_bastion_type    = var.pnap_bastion_type
  pnap_esx_type        = var.pnap_esx_type
  pnap_create_network  = var.pnap_create_network
  pnap_priv_network_id = var.pnap_priv_network_id
  pnap_pub_network_id  = var.pnap_pub_network_id
  cluster_name         = local.cluster_name
}

locals {
  pnap_bastion_ip    = var.cloud == "PNAP" ? module.PNAP_Infra.0.bastion_ip : ""
  pnap_bastion_user  = var.cloud == "PNAP" ? module.PNAP_Infra.0.bastion_user : ""
  pnap_pub_vlan_id   = var.cloud == "PNAP" ? module.PNAP_Infra.0.pub_vlan_id : ""
  pnap_priv_vlan_id  = var.cloud == "PNAP" ? module.PNAP_Infra.0.priv_vlan_id : ""
  pnap_pub_cidr      = var.cloud == "PNAP" ? module.PNAP_Infra.0.pub_cidr : ""
  pnap_priv_cidr     = var.cloud == "PNAP" ? module.PNAP_Infra.0.priv_cidr : ""
  pnap_esx_pub_ips   = var.cloud == "PNAP" ? module.PNAP_Infra.0.esx_pub_ips : []
  pnap_esx_priv_ips  = var.cloud == "PNAP" ? module.PNAP_Infra.0.esx_priv_ips : []
  pnap_esx_passwords = var.cloud == "PNAP" ? module.PNAP_Infra.0.esx_passwords : []
  bastion_ip         = coalesce(local.pnap_bastion_ip)
  bastion_user       = coalesce(local.pnap_bastion_user)
  pub_vlan_id        = coalesce(local.pnap_pub_vlan_id)
  priv_vlan_id       = coalesce(local.pnap_priv_vlan_id)
  pub_cidr           = coalesce(local.pnap_pub_cidr)
  priv_cidr          = coalesce(local.pnap_priv_cidr)
  esx_pub_ips        = coalescelist(local.pnap_esx_pub_ips)
  esx_priv_ips       = coalescelist(local.pnap_esx_priv_ips)
  esx_passwords      = coalescelist(local.pnap_esx_passwords)
}

module "Ansible_Bootstrap" {
  depends_on = [
    module.GCP_Auth,
    module.PNAP_Infra
  ]
  source = "./modules/ansible-bootstrap"
  ssh_key = {
    private_key = chomp(tls_private_key.ssh_key_pair.private_key_pem)
    public_key  = chomp(tls_private_key.ssh_key_pair.public_key_openssh)
  }
  bastion_ip               = local.bastion_ip
  bastion_user             = local.bastion_user
  pub_vlan_id              = local.pub_vlan_id
  priv_vlan_id             = local.priv_vlan_id
  esx_pub_ips              = local.esx_pub_ips
  esx_priv_ips             = local.esx_priv_ips
  esx_passwords            = local.esx_passwords
  ansible_tar_ball         = var.ansible_tar_ball
  ansible_url              = var.ansible_url
  ansible_playbook_version = var.ansible_playbook_version
  gcp_master_sa_key        = module.GCP_Auth.master_sa_key
  esx_node_count           = var.esx_node_count
  gcp_project_id           = var.gcp_project_id
  pub_cidr                 = local.pub_cidr
  priv_cidr                = local.priv_cidr
  cluster_name             = local.cluster_name
}
