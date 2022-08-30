<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The ABM cluster name | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID to use (Same variable for GCP and EQM) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_sa_key"></a> [master\_sa\_key](#output\_master\_sa\_key) | GCP Master Service Account JSON Key |
<!-- END_TF_DOCS -->