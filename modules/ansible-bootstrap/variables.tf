variable "ssh_key" {
  type = object({
    public_key  = string
    private_key = string
  })
  description = "SSH Public and Private Key"
}

variable "bastion_ip" {
  type        = string
  description = "The bastion host/admin workstation public IP Address"
}

variable "ansible_url" {
  type        = string
  description = "URL of the ansible code"
}

variable "ansible_tar_ball" {
  type        = string
  description = "Tarball of the ansible code"
}

variable "bastion_user" {
  type        = string
  description = "The username used to ssh to hosts"
}

variable "esx_priv_ips" {
  type        = list(string)
  description = "The private IP addresses for esx Hosts"
}

variable "pub_cidr" {
  type        = string
  description = "The public IP CIDR"
}

variable "priv_cidr" {
  type        = string
  description = "The private IP CIDR"
}

variable "gcp_master_sa_key" {
  type        = string
  description = "GCP Master Service Account Key"
}

variable "esx_node_count" {
  type        = number
  description = "How many esx nodes were deployed"
}

variable "gcp_project_id" {
  type        = string
  description = "The project ID to use (Same variable for GCP and EQM)"
}

variable "pub_vlan_id" {
  type        = number
  description = "Public Networks vLan ID"
}

variable "priv_vlan_id" {
  type        = number
  description = "Private Networks vLan ID"
}

variable "esx_passwords" {
  type        = list(string)
  description = "The root passwords for the esx hosts"
}

variable "cluster_name" {
  description = "This will be the name of the k8s cluster"
  type        = string
}

variable "s3_url" {
  description = "This is the URL endpoint to connect your s3 client to"
  type        = string
}

variable "s3_access_key" {
  description = "This is the access key for your S3 endpoint"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "This is the secret key for your S3 endpoint"
  type        = string
  sensitive   = true
}

variable "object_store_api" {
  description = "Which api should you use to download objects from the object store? ('gcs' and 's3' are supported.)"
  type        = string
}

variable "object_store_bucket_name" {
  description = "This is the name of the bucket on your Object Store"
  type        = string
}

variable "vcenter_iso_name" {
  description = "The name of the vCenter ISO in your Object Store"
  type        = string
}

variable "vcenter_datacenter_name" {
  description = "This will be the name of the vCenter Datacenter object."
  type        = string
}

variable "vcenter_cluster_name" {
  description = "This will be the name of the vCenter Cluster object."
  type        = string
}

variable "vcenter_domain" {
  description = "This will be the vSphere SSO domain."
  type        = string
}
