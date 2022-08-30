<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public and Private Key | <pre>object({<br>    public_key  = string<br>    private_key = string<br>  })</pre> | n/a | yes |
| <a name="input_bastion_ip"></a> [bastion\_ip](#input\_bastion\_ip) | The bastion host/admin workstation public IP Address | `string` | n/a | yes |
| <a name="input_ansible_playbook_version"></a> [ansible\_playbook\_version](#input\_ansible\_playbook\_version) | The version of the ansible playbook to install | `string` | n/a | yes |
| <a name="input_ansible_url"></a> [ansible\_url](#input\_ansible\_url) | URL of the ansible code | `string` | n/a | yes |
| <a name="input_ansible_tar_ball"></a> [ansible\_tar\_ball](#input\_ansible\_tar\_ball) | Tarball of the ansible code | `string` | n/a | yes |
<!-- END_TF_DOCS -->