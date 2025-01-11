# https://pve.proxmox.com/pve-docs/api-viewer/index.html#/access/ticket
data "http" "pve-ticket" {
  count = var.pve-auth != null ? 1 : 0

  url      = "${var.pve-endpoint}/api2/json/access/ticket"
  insecure = var.pve-endpoint-insecure
  method   = "POST"

  request_headers = {
    "Accept" = "application/json"
    "Content-Type" : "application/json"
  }

  request_body = jsonencode({
    username = var.pve-auth.username
    password = var.pve-auth.password
  })

  lifecycle {
    precondition {
      condition     = (var.pve-auth != null && var.pve-token == null)
      error_message = "Either (username and password) or (token) must be provided"
    }

    postcondition {
      condition     = contains([200, 201, 203, 204], self.status_code)
      error_message = "Failed to request proxmox auth ticket ${self.status_code}"
    }
  }
}


locals {
  pve-ticket                = try(jsondecode(data.http.pve-ticket[0].response_body).data.ticket, "")
  pve-csrf-prevention-token = try(jsondecode(data.http.pve-ticket[0].response_body).data.CSRFPreventionToken, "")
}


# https://pve.proxmox.com/pve-docs/api-viewer/index.html#/cluster/options
data "httpclient_request" "pve-update-notes-with-username" {
  count = var.pve-auth != null ? 1 : 0

  url            = "${var.pve-endpoint}/api2/json/cluster/options"
  insecure       = var.pve-endpoint-insecure
  request_method = "PUT"

  request_headers = {
    "Accept"              = "application/json"
    "Content-Type"        = "application/json"
    "Cookie"              = "PVEAuthCookie=${local.pve-ticket}"
    "CSRFPreventionToken" = local.pve-csrf-prevention-token
  }

  request_body = jsonencode({
    description = var.cluster-note
  })

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 203, 204], self.response_code)
      error_message = "Failed to update proxmox tag options ${self.response_code}"
    }
  }
}
