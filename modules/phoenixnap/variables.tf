variable "esx_node_count" {
  type        = number
  description = "How many esx nodes to deploy"
}

variable "pnap_location" {
  type        = string
  description = "PhoenixNAP Location to deploy into"
}

variable "pnap_bastion_type" {
  type        = string
  description = "PhoenixNAP server type to deploy for the bastion host"
}

variable "pnap_esx_type" {
  type        = string
  description = "PhoenixNAP server type to deploy for esx nodes"
}

variable "pnap_create_network" {
  type        = bool
  description = "Create a new network if this is 'true'. Else use provided 'pnap_network_name'"
}

variable "pnap_pub_network_id" {
  type        = string
  description = "The id of the public network to use when creating servers in PNAP"
}

variable "pnap_priv_network_id" {
  type        = string
  description = "The id of the private network to use when creating servers in PNAP"
}

variable "cluster_name" {
  description = "This will be the name of the k8s cluster"
  type        = string
}

variable "vsphere_os" {
  description = "This is the version of vSphere that you want to deploy (esx 7.0 have been tested)"
  type        = string
  default     = "vmware_esx_7_0"
}

variable "bastion_os" {
  description = "This is the operating system for the bastion host (Ubuntu 20.04 has been tested)"
  type        = string
  default     = "ubuntu_20_04"
}

variable "ssh_key" {
  type = object({
    public_key  = string
    private_key = string
  })
  description = "SSH Public and Private Key"
}