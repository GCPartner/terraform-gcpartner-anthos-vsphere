terraform {
  required_providers {
    pnap = {
      source = "phoenixnap/pnap"
    }
  }
}

locals {
  bastion_os_image = var.bastion_os == "ubuntu_20_04" ? "ubuntu/focal" : ""
  esx_os_image     = var.vsphere_os == "vmware_esx_7" ? "esxi/esxi70u2" : ""
  bastion_username = "ubuntu"
  pnap_priv_subnet = "10.11.12.0/24"
}

resource "pnap_ip_block" "new_ip_block" {
  count           = var.pnap_create_network ? 1 : 0
  location        = var.pnap_location
  cidr_block_size = "/28"
  description     = "IP block for public hosts and k8s services"
}

resource "pnap_public_network" "new_network" {
  count       = var.pnap_create_network ? 1 : 0
  name        = format("%s-public-net", var.cluster_name)
  description = format("Public Network for:  %s", var.cluster_name)
  location    = var.pnap_location
  ip_blocks {
    public_network_ip_block {
      id = pnap_ip_block.new_ip_block[0].id
    }
  }
}

data "pnap_public_network" "existing_network" {
  count = var.pnap_create_network ? 0 : 1
  id    = var.pnap_pub_network_id
}

data "pnap_ip_block" "existing_ip_block" {
  count = var.pnap_create_network ? 0 : 1
  id    = data.pnap_public_network.existing_network[0].ip_blocks[0].id
}

resource "pnap_private_network" "new_network" {
  count    = var.pnap_create_network ? 1 : 0
  name     = format("%s-private-net", var.cluster_name)
  cidr     = local.pnap_priv_subnet
  location = var.pnap_location
}

data "pnap_private_network" "existing_network" {
  count = var.pnap_create_network ? 0 : 1
  id    = var.pnap_priv_network_id
}

locals {
  pub_network  = var.pnap_create_network ? pnap_public_network.new_network[0] : data.pnap_public_network.existing_network[0]
  priv_network = var.pnap_create_network ? pnap_private_network.new_network[0] : data.pnap_private_network.existing_network[0]
  ip_block     = var.pnap_create_network ? pnap_ip_block.new_ip_block[0] : data.pnap_ip_block.existing_ip_block[0]
}

resource "pnap_server" "bastion_host" {
  depends_on = [
    pnap_public_network.new_network,
    pnap_ip_block.new_ip_block,
    data.pnap_public_network.existing_network,
    data.pnap_ip_block.existing_ip_block
  ]
  hostname = format("%s-bastion", var.cluster_name)
  os       = local.bastion_os_image
  type     = var.pnap_bastion_type
  location = var.pnap_location
  ssh_keys = [
    var.ssh_key.public_key
  ]
  management_access_allowed_ips = ["0.0.0.0/0"]
  network_configuration {
    private_network_configuration {
      configuration_type = "USER_DEFINED"
      private_networks {
        server_private_network {
          id  = local.priv_network.id
          ips = [cidrhost(local.priv_network.cidr, 2)]
        }
      }
    }
    ip_blocks_configuration {
      configuration_type = "NONE"
    }
    public_network_configuration {
      public_networks {
        server_public_network {
          id  = local.pub_network.id
          ips = [cidrhost(local.ip_block.cidr, 2)]
        }
      }
    }
    gateway_address = cidrhost(local.ip_block.cidr, 1)
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "pnap_server" "esx_hosts" {
  count = var.esx_node_count
  depends_on = [
    pnap_public_network.new_network,
    pnap_ip_block.new_ip_block,
    data.pnap_public_network.existing_network,
    data.pnap_ip_block.existing_ip_block
  ]
  hostname = format("%s-esx%02d", var.cluster_name, count.index + 1)
  os       = local.esx_os_image
  type     = var.pnap_esx_type
  location = var.pnap_location
  ssh_keys = [
    var.ssh_key.public_key
  ]
  management_access_allowed_ips = ["0.0.0.0/0"]
  network_type                  = "PRIVATE_ONLY"
  network_configuration {
    private_network_configuration {
      configuration_type = "USER_DEFINED"
      private_networks {
        server_private_network {
          id  = local.priv_network.id
          ips = [cidrhost(local.priv_network.cidr, count.index + 4)]
        }
      }
    }
    ip_blocks_configuration {
      configuration_type = "NONE"
    }
  }
  lifecycle {
    ignore_changes = all
  }
}
