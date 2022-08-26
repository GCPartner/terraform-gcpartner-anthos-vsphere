output "esxi_host_ips" {
  value = pnap_server.esxi_hosts[*].public_ip_addresses
}
output "esxi_host_passwords" {
  value = pnap_server.esxi_hosts[*].root_password
}
output "esxi_mgmt_url" {
  value = pnap_server.esxi_hosts[*].management_ui_url
}
