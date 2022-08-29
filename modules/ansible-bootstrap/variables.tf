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
