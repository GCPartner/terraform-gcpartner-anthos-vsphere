[![Anthos on vSphere Website](https://img.shields.io/badge/Website-cloud.google.com/anthos-blue)](https://cloud.google.com/anthos) [![Apache License](https://img.shields.io/github/license/GCPartner/terraform-gcpartner-anthos-vsphere)](https://github.com/GCPartner/terraform-gcpartner-anthos-vsphere/blob/main/LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/GCPartner/terraform-gcpartner-anthos-vsphere/pulls) ![](https://img.shields.io/badge/Stability-Experimental-red.svg)
# Google Anthos on vSphere
This [Terraform](http://terraform.io) module will allow you to deploy [Google Cloud's Anthos on vSphere](https://cloud.google.com/anthos) on Multiple different Clouds (PhoenixNAP, & Equinix Metal)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | PNAP (Phoenix Nap) or EQM (Equinx Metal)to deploy the 'Nodes' | `string` | `"PNAP"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | How many ESXi nodes to deploy | `number` | `3` | no |
| <a name="input_bastion_os"></a> [bastion\_os](#input\_bastion\_os) | This is the operating system for the bastion host (Ubuntu 20.04 has been tested) | `string` | `"ubuntu_20_04"` | no |
| <a name="input_vsphere_os"></a> [vsphere\_os](#input\_vsphere\_os) | This is the version of vSphere that you want to deploy (ESXi 7.0 have been tested) | `string` | `"vmware_esxi_7"` | no |
| <a name="input_vcenter_datacenter_name"></a> [vcenter\_datacenter\_name](#input\_vcenter\_datacenter\_name) | This will be the name of the vCenter Datacenter object. | `string` | `"Google"` | no |
| <a name="input_vcenter_cluster_name"></a> [vcenter\_cluster\_name](#input\_vcenter\_cluster\_name) | This will be the name of the vCenter Cluster object. | `string` | `"Anthos"` | no |
| <a name="input_vcenter_domain"></a> [vcenter\_domain](#input\_vcenter\_domain) | This will be the vSphere SSO domain. | `string` | `"vsphere.local"` | no |
| <a name="input_vcenter_user_name"></a> [vcenter\_user\_name](#input\_vcenter\_user\_name) | This will be the admin user for vSphere SSO | `string` | `"Administrator"` | no |
| <a name="input_s3_url"></a> [s3\_url](#input\_s3\_url) | This is the URL endpoint to connect your s3 client to | `string` | `"https://s3.example.com"` | no |
| <a name="input_s3_access_key"></a> [s3\_access\_key](#input\_s3\_access\_key) | This is the access key for your S3 endpoint | `string` | `"S3_ACCESS_KEY"` | no |
| <a name="input_s3_secret_key"></a> [s3\_secret\_key](#input\_s3\_secret\_key) | This is the secret key for your S3 endpoint | `string` | `"S3_SECRET_KEY"` | no |
| <a name="input_s3_version"></a> [s3\_version](#input\_s3\_version) | S3 API Version (S3v2, S3v4) | `string` | `"S3v4"` | no |
| <a name="input_object_store_tool"></a> [object\_store\_tool](#input\_object\_store\_tool) | Which tool should you use to download objects from the object store? ('mc' and 'gcs' have been tested.) | `string` | `"mc"` | no |
| <a name="input_object_store_bucket_name"></a> [object\_store\_bucket\_name](#input\_object\_store\_bucket\_name) | This is the name of the bucket on your Object Store | `string` | `"vmware"` | no |
| <a name="input_gcs_key_name"></a> [gcs\_key\_name](#input\_gcs\_key\_name) | If you are using GCS to download your vCenter ISO this is the name of the GCS key | `string` | `"storage-reader-key.json"` | no |
| <a name="input_path_to_gcs_key"></a> [path\_to\_gcs\_key](#input\_path\_to\_gcs\_key) | If you are using GCS to download your vCenter ISO this is the absolute path to the GCS key (ex: /home/example/storage-reader-key.json) | `string` | `"null"` | no |
| <a name="input_relative_path_to_gcs_key"></a> [relative\_path\_to\_gcs\_key](#input\_relative\_path\_to\_gcs\_key) | (Deprecated: use path\_to\_gcs\_key) If you are using GCS to download your vCenter ISO this is the path to the GCS key | `string` | `"null"` | no |
| <a name="input_vcenter_iso_name"></a> [vcenter\_iso\_name](#input\_vcenter\_iso\_name) | The name of the vCenter ISO in your Object Store | `string` | `"null"` | no |
| <a name="input_pnap_client_id"></a> [pnap\_client\_id](#input\_pnap\_client\_id) | PhoenixNAP API ID | `string` | `"null"` | no |
| <a name="input_pnap_client_secret"></a> [pnap\_client\_secret](#input\_pnap\_client\_secret) | PhoenixNAP API Secret | `string` | `"null"` | no |
| <a name="input_pnap_location"></a> [pnap\_location](#input\_pnap\_location) | PhoenixNAP Location to deploy into | `string` | `"ASH"` | no |
| <a name="input_pnap_bastion_type"></a> [pnap\_bastion\_type](#input\_pnap\_bastion\_type) | PhoenixNAP server type to deploy for the bastion host | `string` | `"s2.c1.medium"` | no |
| <a name="input_pnap_esxi_type"></a> [pnap\_esxi\_type](#input\_pnap\_esxi\_type) | PhoenixNAP server type to deploy for esxi nodes | `string` | `"s2.c1.medium"` | no |
| <a name="input_pnap_create_network"></a> [pnap\_create\_network](#input\_pnap\_create\_network) | Create a new network if this is 'true'. Else use provided 'pnap\_network\_name' | `bool` | `false` | no |
| <a name="input_pnap_network_name"></a> [pnap\_network\_name](#input\_pnap\_network\_name) | The name of the network to use when creating servers in PNAP | `string` | `"null"` | no |
<!-- END_TF_DOCS -->