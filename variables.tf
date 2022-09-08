variable "cloud" {
  type        = string
  default     = "PNAP"
  description = "PNAP (Phoenix Nap) or EQM (Equinx Metal)to deploy the 'Nodes'"
}

variable "esx_node_count" {
  type        = number
  default     = 3
  description = "How many esx nodes to deploy"
}

variable "bastion_os" {
  description = "This is the operating system for the bastion host (Ubuntu 20.04 has been tested)"
  type        = string
  default     = "ubuntu_20_04"
}

# GCP Vars
variable "gcp_project_id" {
  type        = string
  description = "The project ID for GCP"
}

# vSphere Vars
variable "vsphere_os" {
  description = "This is the version of vSphere that you want to deploy (esx 7.0 have been tested)"
  type        = string
  default     = "vmware_esx_7"
}

variable "vcenter_datacenter_name" {
  description = "This will be the name of the vCenter Datacenter object."
  type        = string
  default     = "Google"
}

variable "vcenter_cluster_name" {
  description = "This will be the name of the vCenter Cluster object."
  type        = string
  default     = "Anthos"
}

variable "vcenter_domain" {
  description = "This will be the vSphere SSO domain."
  type        = string
  default     = "vsphere.local"
}

# Object Store Vars
variable "s3_url" {
  description = "This is the URL endpoint to connect your s3 client to"
  type        = string
  default     = "https://s3.example.com"
}

variable "s3_access_key" {
  description = "This is the access key for your S3 endpoint"
  type        = string
  sensitive   = true
  default     = "S3_ACCESS_KEY"
}

variable "s3_secret_key" {
  description = "This is the secret key for your S3 endpoint"
  type        = string
  sensitive   = true
  default     = "S3_SECRET_KEY"
}

variable "object_store_api" {
  description = "Which api should you use to download objects from the object store? ('gcs' and 's3' are supported.)"
  type        = string
  default     = "gcs"
}

variable "object_store_bucket_name" {
  description = "This is the name of the bucket on your Object Store"
  type        = string
  default     = "vmware"
}

variable "vcenter_iso_name" {
  description = "The name of the vCenter ISO in your Object Store"
  type        = string
  default     = "null"
}

# Ansible Vars
variable "ansible_url" {
  type        = string
  description = "URL of the ansible code"
  default     = "https://github.com/GCPartner/ansible-gcpartner-anthos-vsphere/archive/refs/tags/v0.0.1.tar.gz"
}

variable "ansible_tar_ball" {
  type        = string
  description = "Tarball of the ansible code"
  default     = "v0.0.1.tar.gz"
}

# PNAP Vars
variable "pnap_client_id" {
  type        = string
  description = "PhoenixNAP API ID"
  default     = "null"
}

variable "pnap_client_secret" {
  type        = string
  description = "PhoenixNAP API Secret"
  default     = "null"
}

variable "pnap_location" {
  type        = string
  default     = "ASH"
  description = "PhoenixNAP Location to deploy into"
}

variable "pnap_bastion_type" {
  type        = string
  description = "PhoenixNAP server type to deploy for the bastion host"
  default     = "s2.c1.medium"
}

variable "pnap_esx_type" {
  type        = string
  description = "PhoenixNAP server type to deploy for esx nodes"
  default     = "s2.c1.medium"
}

variable "pnap_create_network" {
  type        = bool
  default     = false
  description = "Create a new network if this is 'true'. Else use provided 'pnap_network_name'"
}

variable "pnap_pub_network_id" {
  type        = string
  default     = "null"
  description = "The id of the public network to use when creating servers in PNAP"
}

variable "pnap_priv_network_id" {
  type        = string
  default     = "null"
  description = "The id of the private network to use when creating servers in PNAP"
}

