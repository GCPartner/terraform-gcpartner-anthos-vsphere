[![Anthos on vSphere Website](https://img.shields.io/badge/Website-cloud.google.com/anthos-blue)](https://cloud.google.com/anthos) [![Apache License](https://img.shields.io/github/license/GCPartner/terraform-gcpartner-anthos-vsphere)](https://github.com/GCPartner/terraform-gcpartner-anthos-vsphere/blob/main/LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/GCPartner/terraform-gcpartner-anthos-vsphere/pulls) ![](https://img.shields.io/badge/Stability-Experimental-red.svg)
# Google Anthos on vSphere
This [Terraform](http://terraform.io) module will allow you to deploy [Google Cloud's Anthos on vSphere](https://cloud.google.com/anthos) on Multiple different Clouds (PhoenixNAP, & Equinix Metal)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | PNAP (Phoenix Nap) or EQM (Equinx Metal)to deploy the 'Nodes' | `string` | `"PNAP"` | no |
| <a name="input_esx_node_count"></a> [esx\_node\_count](#input\_esx\_node\_count) | How many esx nodes to deploy | `number` | `3` | no |
| <a name="input_bastion_os"></a> [bastion\_os](#input\_bastion\_os) | This is the operating system for the bastion host (Ubuntu 20.04 has been tested) | `string` | `"ubuntu_20_04"` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID for GCP | `string` | n/a | yes |
| <a name="input_vsphere_os"></a> [vsphere\_os](#input\_vsphere\_os) | This is the version of vSphere that you want to deploy (esx 7.0 have been tested) | `string` | `"vmware_esx_7"` | no |
| <a name="input_vcenter_datacenter_name"></a> [vcenter\_datacenter\_name](#input\_vcenter\_datacenter\_name) | This will be the name of the vCenter Datacenter object. | `string` | `"Google"` | no |
| <a name="input_vcenter_cluster_name"></a> [vcenter\_cluster\_name](#input\_vcenter\_cluster\_name) | This will be the name of the vCenter Cluster object. | `string` | `"Anthos"` | no |
| <a name="input_vcenter_domain"></a> [vcenter\_domain](#input\_vcenter\_domain) | This will be the vSphere SSO domain. | `string` | `"vsphere.local"` | no |
| <a name="input_s3_url"></a> [s3\_url](#input\_s3\_url) | This is the URL endpoint to connect your s3 client to | `string` | `"https://s3.example.com"` | no |
| <a name="input_s3_access_key"></a> [s3\_access\_key](#input\_s3\_access\_key) | This is the access key for your S3 endpoint | `string` | `"S3_ACCESS_KEY"` | no |
| <a name="input_s3_secret_key"></a> [s3\_secret\_key](#input\_s3\_secret\_key) | This is the secret key for your S3 endpoint | `string` | `"S3_SECRET_KEY"` | no |
| <a name="input_object_store_api"></a> [object\_store\_api](#input\_object\_store\_api) | Which api should you use to download objects from the object store? ('gcs' and 's3' are supported.) | `string` | `"gcs"` | no |
| <a name="input_object_store_bucket_name"></a> [object\_store\_bucket\_name](#input\_object\_store\_bucket\_name) | This is the name of the bucket on your Object Store | `string` | `"vmware"` | no |
| <a name="input_vcenter_iso_name"></a> [vcenter\_iso\_name](#input\_vcenter\_iso\_name) | The name of the vCenter ISO in your Object Store | `string` | `"null"` | no |
| <a name="input_ansible_url"></a> [ansible\_url](#input\_ansible\_url) | URL of the ansible code | `string` | `"https://github.com/GCPartner/ansible-gcpartner-anthos-vsphere/archive/refs/tags/v0.0.1.tar.gz"` | no |
| <a name="input_ansible_tar_ball"></a> [ansible\_tar\_ball](#input\_ansible\_tar\_ball) | Tarball of the ansible code | `string` | `"v0.0.1.tar.gz"` | no |
| <a name="input_pnap_client_id"></a> [pnap\_client\_id](#input\_pnap\_client\_id) | PhoenixNAP API ID | `string` | `"null"` | no |
| <a name="input_pnap_client_secret"></a> [pnap\_client\_secret](#input\_pnap\_client\_secret) | PhoenixNAP API Secret | `string` | `"null"` | no |
| <a name="input_pnap_location"></a> [pnap\_location](#input\_pnap\_location) | PhoenixNAP Location to deploy into | `string` | `"ASH"` | no |
| <a name="input_pnap_bastion_type"></a> [pnap\_bastion\_type](#input\_pnap\_bastion\_type) | PhoenixNAP server type to deploy for the bastion host | `string` | `"s2.c1.medium"` | no |
| <a name="input_pnap_esx_type"></a> [pnap\_esx\_type](#input\_pnap\_esx\_type) | PhoenixNAP server type to deploy for esx nodes | `string` | `"s2.c1.medium"` | no |
| <a name="input_pnap_create_network"></a> [pnap\_create\_network](#input\_pnap\_create\_network) | Create a new network if this is 'true'. Else use provided 'pnap\_network\_name' | `bool` | `false` | no |
| <a name="input_pnap_pub_network_id"></a> [pnap\_pub\_network\_id](#input\_pnap\_pub\_network\_id) | The id of the public network to use when creating servers in PNAP | `string` | `"null"` | no |
| <a name="input_pnap_priv_network_id"></a> [pnap\_priv\_network\_id](#input\_pnap\_priv\_network\_id) | The id of the private network to use when creating servers in PNAP | `string` | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_esx_priv_ips"></a> [esx\_priv\_ips](#output\_esx\_priv\_ips) | The private IPs for the esx hosts. |
| <a name="output_esx_passwords"></a> [esx\_passwords](#output\_esx\_passwords) | The base64 encoded root passwords for the esx hosts |
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | IP Address of the bastion host in the test environment |
| <a name="output_ssh_key_path"></a> [ssh\_key\_path](#output\_ssh\_key\_path) | Path to the SSH Private key for the bastion host |
| <a name="output_ssh_command"></a> [ssh\_command](#output\_ssh\_command) | Command to run to SSH into the bastion host |
| <a name="output_bastion_host_username"></a> [bastion\_host\_username](#output\_bastion\_host\_username) | Username for the bastion host in the test environment |
| <a name="output_pub_vlan_id"></a> [pub\_vlan\_id](#output\_pub\_vlan\_id) | Public Networks vLan ID |
| <a name="output_priv_vlan_id"></a> [priv\_vlan\_id](#output\_priv\_vlan\_id) | Private Networks vLan ID |
<!-- END_TF_DOCS -->