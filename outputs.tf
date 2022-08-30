output "esx_pub_ips" {
  value       = local.esx_pub_ips
  description = "The public IPs of the esx hosts."
}

output "esx_priv_ips" {
  value       = local.esx_priv_ips
  description = "The private IPs for the esx hosts."
}

output "esx_passwords" {
  value       = local.esx_passwords
  description = "The root passwords for the esx hosts"
}

output "bastion_ip" {
  value       = local.bastion_ip
  description = "IP Address of the bastion host in the test environment"
}

output "ssh_key_path" {
  value       = pathexpand(format("~/.ssh/%s", local.ssh_key_name))
  description = "Path to the SSH Private key for the bastion host"
}

output "ssh_command" {
  value       = format("ssh -i %s %s@%s", pathexpand(format("~/.ssh/%s", local.ssh_key_name)), local.bastion_user, local.bastion_ip)
  description = "Command to run to SSH into the bastion host"
}

output "bastion_host_username" {
  value       = local.bastion_user
  description = "Username for the bastion host in the test environment"
}

output "pub_vlan_id" {
  value       = local.pub_vlan_id
  description = "Public Networks vLan ID"
}

output "priv_vlan_id" {
  value       = local.priv_vlan_id
  description = "Private Networks vLan ID"
}