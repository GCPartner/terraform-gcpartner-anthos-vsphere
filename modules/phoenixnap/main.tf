terraform {
  required_providers {
    pnap = {
      source = "phoenixnap/pnap"
    }
  }
}

locals {
  bastion_os_image = var.bastion_os == "ubuntu_20_04" ? "ubuntu/focal" : ""
  esx_os_image     = var.vsphere_os == "vmware_esxi_7" ? "esxi/esxi70u2" : ""
  bastion_username = "ubuntu"
}

resource "pnap_ip_block" "new_ip_block" {
  count           = var.pnap_create_network ? 1 : 0
  location        = var.pnap_location
  cidr_block_size = "/28"
  description     = "IP block for public hosts and k8s services"
}

resource "pnap_public_network" "new_network" {
  count       = var.pnap_create_network ? 1 : 0
  name        = format("%s-public-net", var.vcenter_cluster_name)
  description = format("Public Network for:  %s", var.vcenter_cluster_name)
  location    = var.pnap_location
  ip_blocks {
    public_network_ip_block {
      id = pnap_ip_block.new_ip_block[0].id
    }
  }
}

data "pnap_public_network" "existing_network" {
  count = var.pnap_create_network ? 0 : 1
  name  = var.pnap_network_name
}

data "pnap_ip_block" "existing_ip_block" {
  count = var.pnap_create_network ? 0 : 1
  id    = data.pnap_public_network.existing_network[0].ip_blocks[0].id
}

locals {
  network  = var.pnap_create_network ? pnap_public_network.new_network[0] : data.pnap_public_network.existing_network[0]
  ip_block = var.pnap_create_network ? pnap_ip_block.new_ip_block[0] : data.pnap_ip_block.existing_ip_block[0]
}

resource "pnap_server" "bastion_host" {
  depends_on = [
    pnap_public_network.new_network,
    pnap_ip_block.new_ip_block,
    data.pnap_public_network.existing_network,
    data.pnap_ip_block.existing_ip_block
  ]
  hostname = format("%s-bastion", var.vcenter_cluster_name)
  os       = local.bastion_os_image
  type     = var.pnap_bastion_type
  location = var.pnap_location
  ssh_keys = [
    var.ssh_key.public_key
  ]
  network_configuration {
    public_network_configuration {
      public_networks {
        server_public_network {
          id  = local.network.id
          ips = [cidrhost(local.ip_block.cidr, 2)]
        }
      }
    }
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "pnap_server" "esxi_hosts" {
  count = var.node_count
  depends_on = [
    pnap_public_network.new_network,
    pnap_ip_block.new_ip_block,
    data.pnap_public_network.existing_network,
    data.pnap_ip_block.existing_ip_block
  ]
  hostname = format("%s-esx%02d", var.vcenter_cluster_name, count.index + 1)
  os       = local.esx_os_image
  type     = var.pnap_esxi_type
  location = var.pnap_location
  ssh_keys = [
    var.ssh_key.public_key
  ]
  network_configuration {
    public_network_configuration {
      public_networks {
        server_public_network {
          id  = local.network.id
          ips = [cidrhost(local.ip_block.cidr, count.index + 3)]
        }
      }
    }
  }
  lifecycle {
    ignore_changes = all
  }
}
