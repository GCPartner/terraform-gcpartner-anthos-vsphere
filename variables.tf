variable "cloud" {
  type        = string
  default     = "PNAP"
  description = "PNAP (Phoenix Nap) or EQM (Equinx Metal)to deploy the 'Nodes'"
}

variable "node_count" {
  type        = number
  default     = 3
  description = "How many ESXi nodes to deploy"
}

variable "bastion_os" {
  description = "This is the operating system for the bastion host (Ubuntu 20.04 has been tested)"
  type        = string
  default     = "ubuntu_20_04"
}

# vSphere Vars
variable "vsphere_os" {
  description = "This is the version of vSphere that you want to deploy (ESXi 7.0 have been tested)"
  type        = string
  default     = "vmware_esxi_7"
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

variable "vcenter_user_name" {
  description = "This will be the admin user for vSphere SSO"
  type        = string
  default     = "Administrator"
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

variable "s3_version" {
  description = "S3 API Version (S3v2, S3v4)"
  type        = string
  default     = "S3v4"
}

variable "object_store_tool" {
  description = "Which tool should you use to download objects from the object store? ('mc' and 'gcs' have been tested.)"
  type        = string
  default     = "mc"
}

variable "object_store_bucket_name" {
  description = "This is the name of the bucket on your Object Store"
  type        = string
  default     = "vmware"
}

variable "gcs_key_name" {
  description = "If you are using GCS to download your vCenter ISO this is the name of the GCS key"
  type        = string
  default     = "storage-reader-key.json"
}

variable "path_to_gcs_key" {
  description = "If you are using GCS to download your vCenter ISO this is the absolute path to the GCS key (ex: /home/example/storage-reader-key.json)"
  type        = string
  default     = "null"
}

variable "relative_path_to_gcs_key" {
  description = "(Deprecated: use path_to_gcs_key) If you are using GCS to download your vCenter ISO this is the path to the GCS key"
  type        = string
  default     = "null"
}

variable "vcenter_iso_name" {
  description = "The name of the vCenter ISO in your Object Store"
  type        = string
  default     = "null"
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

variable "pnap_esxi_type" {
  type        = string
  description = "PhoenixNAP server type to deploy for esxi nodes"
  default     = "s2.c1.medium"
}

variable "pnap_create_network" {
  type        = bool
  default     = false
  description = "Create a new network if this is 'true'. Else use provided 'pnap_network_name'"
}

variable "pnap_network_name" {
  type        = string
  default     = "null"
  description = "The name of the network to use when creating servers in PNAP"
}
