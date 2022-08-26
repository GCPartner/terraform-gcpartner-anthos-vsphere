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
  pnap_network_name    = var.pnap_network_name
  vcenter_cluster_name = lower(var.vcenter_cluster_name)
}