# Proxmox cluster note module

This module allows to modify proxmox ve cluster note.

> [!WARNING]
> This module is unable to compare desired and actual state and will apply changes on every plan and apply

> [!CAUTION]
> Deprecated, this module was a workaround of [bpg/proxmox/proxmox_virtual_environment_cluster_options](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_cluster_options) as at the moment of creation it didn't support cluster note modification


## Usage

```hcl
module "cluster-note" {
  source       = "github.com/deinsone/terraform-pve-cluster-note.git"
  cluster-note = file("./cluster-note.md")

  pve-endpoint = local.pve-endpoint

  # token auth
  pve-token = "user@relm!tokenid=secret"

  # or user auth, only one of them is accepted
  pve-auth = {
    username = "user@relm"
    password = "123123"
  }
}
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.3 |
| <a name="requirement_httpclient"></a> [httpclient](#requirement\_httpclient) | 0.3.0 |


## Resources

| Name | Type |
|------|------|
| [http_http.pve-ticket](https://registry.terraform.io/providers/hashicorp/http/3.4.3/docs/data-sources/http) | data source |
| [httpclient_request.pve-update-notes-with-token](https://registry.terraform.io/providers/dmachard/http-client/0.3.0/docs/data-sources/request) | data source |
| [httpclient_request.pve-update-notes-with-username](https://registry.terraform.io/providers/dmachard/http-client/0.3.0/docs/data-sources/request) | data source |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster-note"></a> [cluster-note](#input\_cluster-note) | (required) text of pve cluster note, can be `plaintext` or `markdown` | `string` | n/a | yes |
| <a name="input_pve-auth"></a> [pve-auth](#input\_pve-auth) | (optional) perform username & password authentication, user should have at least `Sys.Modify` permission | <pre>object({<br/>    username = string # `user@relm`<br/>    password = string<br/>  })</pre> | `null` | no |
| <a name="input_pve-endpoint"></a> [pve-endpoint](#input\_pve-endpoint) | (required) pve endpoint in form of `https://example.com:8006` | `string` | n/a | yes |
| <a name="input_pve-endpoint-insecure"></a> [pve-endpoint-insecure](#input\_pve-endpoint-insecure) | (optional) whether to verify endpoint certificate | `bool` | `false` | no |
| <a name="input_pve-token"></a> [pve-token](#input\_pve-token) | (optional) perform token authentication, token should have at least `Sys.Modify` permission, e.g `user@relm!tokenid=secret` | `string` | `null` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster-note"></a> [cluster-note](#output\_cluster-note) | n/a |
| <a name="output_pve-endpoint"></a> [pve-endpoint](#output\_pve-endpoint) | n/a |
| <a name="output_pve-endpoint-insecure"></a> [pve-endpoint-insecure](#output\_pve-endpoint-insecure) | n/a |