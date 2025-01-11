# https://pve.proxmox.com/pve-docs/api-viewer/index.html#/cluster/options
data "httpclient_request" "pve-update-notes-with-token" {
  count = var.pve-token != null ? 1 : 0

  url            = "${var.pve-endpoint}/api2/json/cluster/options"
  insecure       = var.pve-endpoint-insecure
  request_method = "PUT"

  request_headers = {
    "Accept"        = "application/json"
    "Content-Type"  = "application/json"
    "Authorization" = "PVEAPIToken=${var.pve-token}"
  }

  request_body = jsonencode({
    description = var.cluster-note
  })

  lifecycle {
    precondition {
      condition     = (var.pve-token != null && var.pve-auth == null)
      error_message = "Either (username and password) or (token) must be provided"
    }

    postcondition {
      condition     = contains([200, 201, 203, 204], self.response_code)
      error_message = "Failed to update proxmox cluster note ${self.response_code}"
    }
  }
}
