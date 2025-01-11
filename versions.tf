terraform {
  required_providers {
    # The provider doesn't support put method
    http = {
      source  = "hashicorp/http"
      version = "3.4.3"
    }

    # An alternative to be used for put requests
    httpclient = {
      version = "0.3.0"
      source  = "dmachard/http-client"
    }
  }
}
