########## App Gateway Settings ####################

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    it_Environment = "dev"
    it_Owner = "xxx@ciena.com"
    it_App = "Application Gateway"
}
}

variable "app_gateway_name" {
  description = "The name of the application gateway"
  default     = ""
}

variable "app_gateway_public_ip_name" {
  description = "The name of the application gateway public ip"
  default     = ""
}

variable "zones" {
  description = "A collection of availability zones to spread the Application Gateway over."
  type        = list(string)
  default     = [] #["1", "2", "3"]
}

variable "sku" {
  description = "The sku pricing model of v1 and v2"
  type = object({
    name     = string
    tier     = string
    capacity = optional(number)
  })
  default = {
    capacity = 2
    name = "WAF_v2"
    tier = "WAF_v2"
  }
}

variable "autoscale_configuration" {
  description = "Minimum or Maximum capacity for autoscaling. Accepted values are for Minimum in the range 0 to 100 and for Maximum in the range 2 to 125"
  type = object({
    min_capacity = number  
    max_capacity = number
  })
  default = null
}

########## Networking Settings ####################
variable "vnet_resource_group_name" {
  description = "The resource group name where the virtual network is created"
  default     = ""
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}

variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  default     = ""
}

variable "private_ip_address" {
  description = "Private IP Address to assign to the Load Balancer."
}

########  Key Vault & App Gateway Identity Settings ###############################

variable "key_vault_resource_group_name" {
  description = "The resource group name where the key vault is created"
  default     = ""
}

variable "key_vault_name" {
  description = "The name of the key vault for certificate"
  default     = ""
}

variable "cert_name_ciena" {
  description = "The name of the certificate for 'ciena.com'"
  default     = "CienaEntrustWildcard21-22"
}

variable "cert_name_cs_ciena" {
  description = "The name of the certificate for 'cs.ciena.com'"
  default     = "cs-ciena"
}

variable "identity_ids" {
  description = "Specifies a list with a single user managed identity id to be assigned to the Application Gateway"
  default     = []
}

########  Applications Settings ###############################

variable "frontend_ports" {
  description = "List of backend address pools"
  type = list(object({
    name         = string
    port         = number
  }))
  default = [ {
    name = "https"
    port = 43
  },
  {
    name = "http"
    port = 80
  } ]
}

variable "backend_address_pools" {
  description = "List of backend address pools"
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
}


variable "backend_http_settings" {
  description = "List of backend HTTP settings."
  type = list(object({
    name                                = string
    cookie_based_affinity               = string # "Enabled" or "Disabled".
    affinity_cookie_name                = optional(string) # mcadev.cs.ciena.com
    path                                = optional(string) 
    port                                = number
    protocol                            = string
    request_timeout                     = number
    probe_name                          = optional(string)
    host_name                           = optional(string)   
    pick_host_name_from_backend_address = optional(bool)

  }))
}

variable "http_listeners" {
  description = "List of HTTP/HTTPS listeners. SSL Certificate name is required"
  type = list(object({
    name                 = string
    frontend_port_name   = string
    host_name            = optional(string)
    protocol             = string # "Http" or "Https"
    require_sni          = optional(bool) # true or false
    ssl_certificate_name = optional(string)

  }))
}


variable "request_routing_rules" {
  description = "List of Request routing rules to be used for listeners."
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    url_path_map_name           = optional(string)
    priority                    = number
  }))
  default = []
}

variable "url_path_maps" {
  description = "List of URL path maps associated to path-based rules."
  type = list(object({
    name                                = string
    default_backend_http_settings_name  = optional(string)
    default_backend_address_pool_name   = optional(string)
    default_redirect_configuration_name = optional(string)
    path_rules = list(object({
      name                        = string
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      paths                       = list(string)
      redirect_configuration_name = optional(string)
    }))
  }))
  default = []
}

variable "redirect_configuration" {
  description = "list of maps for redirect configurations"
  type        = list(map(string))
  default     = []
}

variable "health_probes" {
  description = "List of Health probes used to test backend pools health."
  type = list(object({
    name                                      = string
    host                                      = string
    interval                                  = number
    path                                      = string
    timeout                                   = number
    unhealthy_threshold                       = number
    protocol                                  = string # Https or Https
  }))
  default = []
}

########## Diagnostic Log Settings ####################

variable "log_analytics_workspace_name" {
  description = "The name of log analytics workspace name"
  default     = null
}


variable "log_analytics_workspace_resource_group_name" {
  description = "The name of log analytics workspace resource group"
  default     = null
}


variable "storage_account_name" {
  description = "The name of the hub storage account to store logs"
  default     = null
}

variable "storage_account_resource_group" {
  description = "The name of the logging storage account resource group to store logs"
  default     = null
}

variable "log_retention_days" {
  description = "Retention days for the logs"
  default     = 5
}

variable "agw_diag_logs" {
  description = "Application Gateway Monitoring Category details for Azure Diagnostic setting"
  default     = ["ApplicationGatewayAccessLog", "ApplicationGatewayPerformanceLog", "ApplicationGatewayFirewallLog"]
}




