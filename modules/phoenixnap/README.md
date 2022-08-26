<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | How many ESXi nodes to deploy | `number` | n/a | yes |
| <a name="input_pnap_location"></a> [pnap\_location](#input\_pnap\_location) | PhoenixNAP Location to deploy into | `string` | n/a | yes |
| <a name="input_pnap_bastion_type"></a> [pnap\_bastion\_type](#input\_pnap\_bastion\_type) | PhoenixNAP server type to deploy for the bastion host | `string` | n/a | yes |
| <a name="input_pnap_esxi_type"></a> [pnap\_esxi\_type](#input\_pnap\_esxi\_type) | PhoenixNAP server type to deploy for esxi nodes | `string` | n/a | yes |
| <a name="input_pnap_create_network"></a> [pnap\_create\_network](#input\_pnap\_create\_network) | Create a new network if this is 'true'. Else use provided 'pnap\_network\_name' | `bool` | n/a | yes |
| <a name="input_pnap_network_name"></a> [pnap\_network\_name](#input\_pnap\_network\_name) | The name of the network to use when creating servers in PNAP | `string` | n/a | yes |
| <a name="input_vcenter_cluster_name"></a> [vcenter\_cluster\_name](#input\_vcenter\_cluster\_name) | This will be the name of the vCenter Cluster object. | `string` | n/a | yes |
| <a name="input_vsphere_os"></a> [vsphere\_os](#input\_vsphere\_os) | This is the version of vSphere that you want to deploy (ESXi 7.0 have been tested) | `string` | `"vmware_esxi_7_0"` | no |
| <a name="input_bastion_os"></a> [bastion\_os](#input\_bastion\_os) | This is the operating system for the bastion host (Ubuntu 20.04 has been tested) | `string` | `"ubuntu_20_04"` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public and Private Key | <pre>object({<br>    public_key  = string<br>    private_key = string<br>  })</pre> | n/a | yes |
<!-- END_TF_DOCS -->