<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public and Private Key | <pre>object({<br>    public_key  = string<br>    private_key = string<br>  })</pre> | n/a | yes |
| <a name="input_bastion_ip"></a> [bastion\_ip](#input\_bastion\_ip) | The bastion host/admin workstation public IP Address | `string` | n/a | yes |
| <a name="input_ansible_playbook_version"></a> [ansible\_playbook\_version](#input\_ansible\_playbook\_version) | The version of the ansible playbook to install | `string` | n/a | yes |
| <a name="input_ansible_url"></a> [ansible\_url](#input\_ansible\_url) | URL of the ansible code | `string` | n/a | yes |
| <a name="input_ansible_tar_ball"></a> [ansible\_tar\_ball](#input\_ansible\_tar\_ball) | Tarball of the ansible code | `string` | n/a | yes |
| <a name="input_bastion_user"></a> [bastion\_user](#input\_bastion\_user) | The username used to ssh to hosts | `string` | n/a | yes |
| <a name="input_esx_priv_ips"></a> [esx\_priv\_ips](#input\_esx\_priv\_ips) | The private IP addresses for esx Hosts | `list(string)` | n/a | yes |
| <a name="input_pub_cidr"></a> [pub\_cidr](#input\_pub\_cidr) | The public IP CIDR | `string` | n/a | yes |
| <a name="input_priv_cidr"></a> [priv\_cidr](#input\_priv\_cidr) | The private IP CIDR | `string` | n/a | yes |
| <a name="input_gcp_master_sa_key"></a> [gcp\_master\_sa\_key](#input\_gcp\_master\_sa\_key) | GCP Master Service Account Key | `string` | n/a | yes |
| <a name="input_esx_node_count"></a> [esx\_node\_count](#input\_esx\_node\_count) | How many esx nodes were deployed | `number` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID to use (Same variable for GCP and EQM) | `string` | n/a | yes |
| <a name="input_pub_vlan_id"></a> [pub\_vlan\_id](#input\_pub\_vlan\_id) | Public Networks vLan ID | `number` | n/a | yes |
| <a name="input_priv_vlan_id"></a> [priv\_vlan\_id](#input\_priv\_vlan\_id) | Private Networks vLan ID | `number` | n/a | yes |
| <a name="input_esx_passwords"></a> [esx\_passwords](#input\_esx\_passwords) | The root passwords for the esx hosts | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | This will be the name of the k8s cluster | `string` | n/a | yes |
| <a name="input_s3_url"></a> [s3\_url](#input\_s3\_url) | This is the URL endpoint to connect your s3 client to | `string` | n/a | yes |
| <a name="input_s3_access_key"></a> [s3\_access\_key](#input\_s3\_access\_key) | This is the access key for your S3 endpoint | `string` | n/a | yes |
| <a name="input_s3_secret_key"></a> [s3\_secret\_key](#input\_s3\_secret\_key) | This is the secret key for your S3 endpoint | `string` | n/a | yes |
| <a name="input_object_store_api"></a> [object\_store\_api](#input\_object\_store\_api) | Which api should you use to download objects from the object store? ('gcs' and 's3' are supported.) | `string` | n/a | yes |
| <a name="input_object_store_bucket_name"></a> [object\_store\_bucket\_name](#input\_object\_store\_bucket\_name) | This is the name of the bucket on your Object Store | `string` | n/a | yes |
| <a name="input_vcenter_iso_name"></a> [vcenter\_iso\_name](#input\_vcenter\_iso\_name) | The name of the vCenter ISO in your Object Store | `string` | n/a | yes |
<!-- END_TF_DOCS -->