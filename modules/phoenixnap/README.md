<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_esx_node_count"></a> [esx\_node\_count](#input\_esx\_node\_count) | How many esx nodes to deploy | `number` | n/a | yes |
| <a name="input_pnap_location"></a> [pnap\_location](#input\_pnap\_location) | PhoenixNAP Location to deploy into | `string` | n/a | yes |
| <a name="input_pnap_bastion_type"></a> [pnap\_bastion\_type](#input\_pnap\_bastion\_type) | PhoenixNAP server type to deploy for the bastion host | `string` | n/a | yes |
| <a name="input_pnap_esx_type"></a> [pnap\_esx\_type](#input\_pnap\_esx\_type) | PhoenixNAP server type to deploy for esx nodes | `string` | n/a | yes |
| <a name="input_pnap_create_network"></a> [pnap\_create\_network](#input\_pnap\_create\_network) | Create a new network if this is 'true'. Else use provided 'pnap\_network\_name' | `bool` | n/a | yes |
| <a name="input_pnap_pub_network_id"></a> [pnap\_pub\_network\_id](#input\_pnap\_pub\_network\_id) | The id of the public network to use when creating servers in PNAP | `string` | n/a | yes |
| <a name="input_pnap_priv_network_id"></a> [pnap\_priv\_network\_id](#input\_pnap\_priv\_network\_id) | The id of the private network to use when creating servers in PNAP | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | This will be the name of the k8s cluster | `string` | n/a | yes |
| <a name="input_vsphere_os"></a> [vsphere\_os](#input\_vsphere\_os) | This is the version of vSphere that you want to deploy (esx 7.0 have been tested) | `string` | `"vmware_esx_7_0"` | no |
| <a name="input_bastion_os"></a> [bastion\_os](#input\_bastion\_os) | This is the operating system for the bastion host (Ubuntu 20.04 has been tested) | `string` | `"ubuntu_20_04"` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public and Private Key | <pre>object({<br>    public_key  = string<br>    private_key = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_esx_priv_ips"></a> [esx\_priv\_ips](#output\_esx\_priv\_ips) | The private IPs for the esx hosts. |
| <a name="output_esx_passwords"></a> [esx\_passwords](#output\_esx\_passwords) | The base64 encoded root passwords for the esx hosts |
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | Bastion Host IP |
| <a name="output_bastion_user"></a> [bastion\_user](#output\_bastion\_user) | Bastion Host username |
| <a name="output_pub_vlan_id"></a> [pub\_vlan\_id](#output\_pub\_vlan\_id) | Public Networks vLan ID |
| <a name="output_priv_vlan_id"></a> [priv\_vlan\_id](#output\_priv\_vlan\_id) | Private Networks vLan ID |
| <a name="output_pub_cidr"></a> [pub\_cidr](#output\_pub\_cidr) | Public Network CIDR |
| <a name="output_priv_cidr"></a> [priv\_cidr](#output\_priv\_cidr) | Private Network CIDR |
<!-- END_TF_DOCS -->