# Rancher Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local)             | 2.4.0    |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh)                   | 2.6.0    |
| <a name="requirement_helm"></a> [helm](#requirement\_helm)                | 2.9.0    |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2)    | 1.25.0   |

## Providers

| Name                                                                                           | Version |
|------------------------------------------------------------------------------------------------|---------|
| <a name="provider_local"></a> [local](#provider\_local)                                        | 2.4.0   |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh)                                              | 1.2.0   |
| <a name="provider_helm"></a> [helm](#provider\_helm)                                           | 2.9.0   |
| <a name="provider_rancher2.admin"></a> [rancher2.admin](#provider\_rancher2.admin)             | 1.25.0  |
| <a name="provider_rancher2.bootstrap"></a> [rancher2.bootstrap](#provider\_rancher2.bootstrap) | 1.25.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                              | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------|----------|
| [local_sensitive_file.kube_config_server_yaml](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/resources/file) | resource |
| [ssh_resource.install_k3s](https://registry.terraform.io/providers/loafoe/ssh/2.6.0/docs/resources/resource)                      | resource |
| [ssh_resource.retrieve_config](https://registry.terraform.io/providers/loafoe/ssh/2.6.0/docs/resources/resource)                  | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release)                  | resource |
| [helm_release.rancher_server](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release)                | resource |
| [rancher2_bootstrap.admin](https://registry.terraform.io/providers/rancher/rancher2/1.25.0/docs/resources/bootstrap)              | resource |

## Inputs

| Name                                                                                                        | Description                                                            | Type     | Default                                               | Required |
|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|----------|-------------------------------------------------------|:--------:|
| <a name="input_node_public_ip"></a> [node\_public\_ip](#input\_node\_public\_ip)                            | Public IP of compute node for Rancher cluster                          | `string` | n/a                                                   |   yes    |
| <a name="input_node_internal_ip"></a> [node\_internal\_ip](#input\_node\_internal\_ip)                      | Internal IP of compute node for Rancher cluster                        | `string` | `""`                                                  |    no    |
| <a name="input_node_username"></a> [node\_username](#input\_node\_username)                                 | Username used for SSH access to the Rancher server cluster node        | `string` | n/a                                                   |   yes    |
| <a name="input_ssh_private_key_pem"></a> [ssh\_private\_key\_pem](#input\_ssh\_private\_key\_pem)           | Private key used for SSH access to the Rancher server cluster node     | `string` | n/a                                                   |   yes    |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version)                  | Kubernetes version to use for Rancher server cluster                   | `string` | `"v1.24.7+k3s1"`                                      |    no    |
| <a name="input_generated_files_dir"></a> [generated\_files\_dir](#input\_generated\_files\_dir)             | Directory where generated files will be stored                         | `string` | `"."`                                                 |    no    |
| <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version)          | Version of cert-manager to install alongside Rancher (format: 0.0.0)   | `string` | `"1.10.1"`                                            |    no    |
| <a name="input_rancher_version"></a> [rancher\_version](#input\_rancher\version)                            | Rancher server version (format v0.0.0)                                 | `string` | `"2.6.10"`                                            |    no    |
| <a name="input_rancher_helm_repository"></a> [rancher\_helm\_repository](#input\_rancher\_helm\_repository) | The helm repository, where the Rancher helm chart is installed from    | `string` | `"https://releases.rancher.com/server-charts/latest"` |    no    |
| <a name="input_rancher_server_dns"></a> [rancher\_server\_dns](#input\_rancher\_server\_dns)                | DNS host name of the Rancher server                                    | `string` | n/a                                                   |   yes    |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password)                              | Admin password to use for Rancher server bootstrap, min. 12 characters | `string` | n/a                                                   |   yes    |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rancher_url"></a> [rancher\_url](#output\_rancher\_url) | n/a |
<!-- END_TF_DOCS -->
