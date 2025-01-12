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
