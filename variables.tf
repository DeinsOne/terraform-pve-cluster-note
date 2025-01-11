variable "pve-endpoint" {
  description = "(required) pve endpoint in form of `https://example.com:8006`"
  type        = string
}


variable "pve-endpoint-insecure" {
  description = "(optional) whether to verify endpoint certificate"
  type        = bool
  default     = false
}


variable "pve-auth" {
  description = "(optional) perform username & password authentication, user should have at least `Sys.Modify` permission"
  default     = null

  type = object({
    username = string # `user@relm`
    password = string
  })
}


variable "pve-token" {
  description = "(optional) perform token authentication, token should have at least `Sys.Modify` permission, e.g `user@relm!tokenid=secret`"
  type        = string
  default     = null
}


variable "cluster-note" {
  description = "(required) text of pve cluster note, can be `plaintext` or `markdown`"
  type        = string
}
