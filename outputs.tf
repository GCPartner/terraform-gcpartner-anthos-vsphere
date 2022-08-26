output "esxi_host_ips" {
  value = module.PNAP_Infra[0].esxi_host_ips
}
output "esxi_host_passwords" {
  value = module.PNAP_Infra[0].esxi_host_passwords
}
output "esxi_mgmt_url" {
  value = module.PNAP_Infra[0].esxi_mgmt_url
}
