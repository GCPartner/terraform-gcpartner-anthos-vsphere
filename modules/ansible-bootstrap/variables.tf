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

variable "ansible_playbook_version" {
  type        = string
  description = "The version of the ansible playbook to install"
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

#variable "esx_pub_ips" {
#  type        = list(string)
#  description = "The public IP addresses for esx Hosts"
#}

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
