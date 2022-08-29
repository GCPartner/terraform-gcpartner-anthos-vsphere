output "esxi_pub_ips" {
  value       = [for pub_ip in pnap_server.esxi_hosts.*.public_ip_addresses : element(tolist(pub_ip), 0)]
  description = "The public IPs of the ESXi hosts."
}
output "esxi_priv_ips" {
  value       = [for priv_ip in pnap_server.esxi_hosts.*.private_ip_addresses : element(tolist(priv_ip), 0)]
  description = "The private IPs for the ESXI hosts."
}
output "esxi_passwords" {
  value       = pnap_server.esxi_hosts[*].root_password
  description = "The root passwords for the ESXi hosts"
}

output "bastion_ip" {
  value       = tolist(pnap_server.bastion_host.public_ip_addresses).0
  description = "Bastion Host IP"
}

output "bastion_user" {
  value       = local.bastion_username
  description = "Bastion Host username"
}

output "pub_vlan_id" {
  value       = local.pub_network.vlan_id
  description = "Public Networks vLan ID"
}

output "priv_vlan_id" {
  value       = local.priv_network.vlan_id
  description = "Private Networks vLan ID"
}
