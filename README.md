# Azure Application Gateway Terraform Module Template

This module creates the application gateway, public IP and diagnostic settings.


## Inputs

## Outputs

## Module Usage
 
 ````
# Azurerm Provider configuration
provider "azurerm" {
  features {}
  subscription_id = "xx-xx-xx-xx-xx"
}


# Data source for current subscription and key vault
data "azurerm_key_vault" "certs_vault" {
  name                = "apps-dev-e2-keyvault"
  resource_group_name = "apps-adminhosts-dev-e2-rg"
}

data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "agw" {
  resource_group_name = "apps-appgw-test-e2-rg"
  location            = "eastus2"
  name                = "apps-test-e2-appgwv2-msi"
}

resource "azurerm_key_vault_access_policy" "agw_managed_identity" {
  key_vault_id = data.azurerm_key_vault.certs_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.agw.principal_id 

  certificate_permissions = [
    "Get","List"
  ]

  secret_permissions = [
    "Get", "List"
  ]
}

module "application-gateway" {
  #source  = "./module/"
  source = "git@github.com:ciena-it/az-terraform-modules.git//modules/network/loadbalancer?ref=SSO-951"
    
  #existing RG name to use an existing resource group.
  resource_group_name = "apps-appgw-jh-e2-rg"
  location = "East Us 2"
  tags  = {
    it_Environment = "dev"
    it_Owner = "jehan@ciena.com"
    it_App = "Application Gateway"
  }
  app_gateway_name = "apps-jhdev-e2-appgwv2"
  app_gateway_public_ip_name = "appsjhdevpip"
  zones = []
  autoscale_configuration = null

  # SKU requires `name`, `tier` to use for this Application Gateway
  # `Capacity` property is optional if `autoscale_configuration` is set
  sku = {
    capacity = 2
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  # networking resources for private IP of the app gateway
  vnet_resource_group_name = "apps-dev-core-e2-rg"
  virtual_network_name = "it-apps-dev-e2-vnet"
  subnet_name = "apps-appgwv2-all-dev-e2-subnet"
  private_ip_address = "10.79.107.145"

  # Key vault and secret resources for certificates of "cs.ciena.com" & "cs.ciena.com"
  key_vault_resource_group_name = "apps-adminhosts-dev-e2-rg"
  key_vault_name = "apps-dev-e2-keyvault"
  cert_name_ciena = "CienaEntrustWildcard21-22" 
  cert_name_cs_ciena = "cs-ciena"

  
  # List of frontend ports.  
  # You can use not only well-known ports, such as 80 and 443, but any allowed custom port that's suitable
  frontend_ports =  [
    {
      name = "https"
      port = 443
    },
    {
      name = "http"
      port = 80
    },
    {
      name = "http-5672"
      port = 5672
    }
  ]

  # A backend pool routes request to backend servers, which serve the request.
  # Can create different backend pools for different types of requests
  backend_address_pools = [
    {
      name  = "productgroupapiinternaldev.cs.ciena.com"
      fqdns = ["cienamcsproductgroupapiinternaldev.azurewebsites.net"]
    },
    {
      name  = "mcadev.cs.ciena.com"
      fqdns = ["cienamcsmcadev.azurewebsites.net"]
    },
    {
      name  = "searchdev.ciena.com"
      fqdns = ["aze2dwsearch01.ciena.com"]
    }
  ]


  # An application gateway routes traffic to the backend servers using the port, protocol, and other settings
  # The port and protocol used to check traffic is encrypted between the application gateway and backend servers
  # List of backend HTTP settings can be added here.  
  # `probe_name` argument is required if you are defing health probes.
  backend_http_settings = [
    {
      name                  = "productgroupapiinternaldev.cs.ciena.com"
      affinity_cookie_name  = "productgroupapiinternaldev.cs.ciena.com"
      cookie_based_affinity = "Disabled"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 600
      probe_name            = "productgroupapiinternaldev.cs.ciena.com-probe"
      host_name             = "productgroupapiinternaldev.cs.ciena.com"
    },
    {
      name                  = "mcadev.cs.ciena.com"
      affinity_cookie_name  = "mcadev.cs.ciena.com"
      cookie_based_affinity = "Enabled"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 600
      probe_name            = "mcadev.cs.ciena.com-probe"
      host_name             = "mcadev.cs.ciena.com"
    },
    {
      name                  = "searchdev.ciena.com-http-5672"
      affinity_cookie_name  = "searchdev.ciena.com"
      cookie_based_affinity = "Enabled"
      port                  = 5672
      protocol              = "Http"
      request_timeout       = 600
      probe_name            = "searchdev.ciena.com-probe"
    },
    {
      name                  = "searchdev.ciena.com"
      affinity_cookie_name  = "searchdev.ciena.com"
      cookie_based_affinity = "Enabled"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 600
      probe_name            = "searchdev.ciena.com-probe"
    }
  ]


  # List of HTTP/HTTPS listeners. SSL Certificate name is required
  # `Basic` - This type of listener listens to a single domain site, where it has a single DNS mapping to the IP address of the 
  # application gateway. This listener configuration is required when you host a single site behind an application gateway.
  # `Multi-site` - This listener configuration is required when you want to configure routing based on host name or domain name for 
  # more than one web application on the same application gateway. Each website can be directed to its own backend pool.
  # Setting `host_name` value changes Listener Type to 'Multi site`. `host_names` allows special wildcard charcters.
  http_listeners = [
    {
      name                           = "productgroupapiinternaldev.cs.ciena.com-http"
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = "productgroupapiinternaldev.cs.ciena.com"
    },
    {
      name                           = "productgroupapiinternaldev.cs.ciena.com-https"
      frontend_port_name             = "https"
      protocol                       = "Https"
      host_name                      = "productgroupapiinternaldev.cs.ciena.com"
      ssl_certificate_name           = "cs.ciena.com"
      require_sni                    = "true"
    },
    {
      name                           = "mcadev.cs.ciena.com-http"
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = "mcadev.cs.ciena.com"
    },
    {
      name                           = "mcadev.cs.ciena.com-https"
      frontend_port_name             = "https"
      protocol                       = "Https"
      host_name                      = "mcadev.cs.ciena.com"
      ssl_certificate_name           = "cs.ciena.com"
      require_sni                    = "true"
    },
    {
      name                           = "searchdev.ciena.com-http-5672"
      frontend_port_name             = "http-5672"
      protocol                       = "Http"
      host_name                      = "searchdev.ciena.com"
    },
    {
      name                           = "searchdev.ciena.com-http"
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = "searchdev.ciena.com"
    },
    {
      name                           = "searchdev.ciena.com-https"
      frontend_port_name             = "https"
      protocol                       = "Https"
      host_name                      = "searchdev.ciena.com"
      ssl_certificate_name           = "ciena.com"
      require_sni                    = "true"
    }
  ]

  # Request routing rule is to determine how to route traffic on the listener. 
  # The rule binds the listener, the back-end server pool, and the backend HTTP settings.
  # `Basic` - All requests on the associated listener (for example, blog.contoso.com/*) are forwarded to the associated 
  # backend pool by using the associated HTTP setting.
  # `Path-based` - This routing rule lets you route the requests on the associated listener to a specific backend pool, 
  # based on the URL in the request. 
  request_routing_rules = [
    {
      name                       = "productgroupapiinternaldev.cs.ciena.com"
      rule_type                  = "Basic"
      http_listener_name         = "productgroupapiinternaldev.cs.ciena.com-https"
      backend_address_pool_name  = "productgroupapiinternaldev.cs.ciena.com"
      backend_http_settings_name = "productgroupapiinternaldev.cs.ciena.com"
      priority                   = 100
    },
    {
      name                        = "productgroupapiinternaldev.cs.ciena.com-http"
      rule_type                   = "Basic"
      http_listener_name          = "productgroupapiinternaldev.cs.ciena.com-http"
      redirect_configuration_name = "productgroupapiinternaldev.cs.ciena.com-redirect"
      priority                   = 101
    },
    {
      name                       = "mcadev.cs.ciena.com"
      rule_type                  = "Basic"
      http_listener_name         = "mcadev.cs.ciena.com-https"
      backend_address_pool_name  = "mcadev.cs.ciena.com"
      backend_http_settings_name = "mcadev.cs.ciena.com"
      priority                   = 102
    },
    {
      name                        = "mcadev.cs.ciena.com-http"
      rule_type                   = "Basic"
      http_listener_name          = "mcadev.cs.ciena.com-http"
      redirect_configuration_name = "mcadev.cs.ciena.com-redirect"
      priority                   = 103
    },
    {
      name                        = "searchdev.ciena.com-http"
      rule_type                   = "Basic"
      http_listener_name          = "searchdev.ciena.com-http"
      redirect_configuration_name = "searchdev.ciena.com-redirect"
      priority                    = 106
    },
    {
      name                        = "searchdev.ciena.com"
      rule_type                   = "PathBasedRouting"
      http_listener_name          = "searchdev.ciena.com-https"
      url_path_map_name           = "searchdev.ciena.com-pathmap-https"
      priority                    = 107
    },
    {
      name                        = "searchdev.ciena.com-http-5672"
      rule_type                   = "PathBasedRouting"
      http_listener_name          = "searchdev.ciena.com-http-5672"
      url_path_map_name           = "searchdev.ciena.com-pathmap-http-5672"
      priority                    = 108
    }
  ]

  # List of redirect configuration.  You can use application gateway to redirect traffic
  # A common redirection scenario for many web applications is to support automatic HTTP to HTTPS redirection to ensure all communication between application and its users occurs over an encrypted path.
  redirect_configuration = [
    {
      name                 = "productgroupapiinternaldev.cs.ciena.com-redirect"
      target_listener_name = "productgroupapiinternaldev.cs.ciena.com-https"
    },
    {
      name                 = "mcadev.cs.ciena.com-redirect"
      target_listener_name = "mcadev.cs.ciena.com-https"
    },
    {
      name                 = "searchdev.ciena.com-redirect"
      target_listener_name = "searchdev.ciena.com-https"
    }
  ]


  # List of url_path_maps.  URL Path Based Routing allows you to route traffic to back-end server pools based on URL Paths of the request.
  # One of the scenarios is to route requests for different content types to different backend server pools.
  url_path_maps = [
    {
      name                               = "searchdev.ciena.com-pathmap-https"
      default_backend_address_pool_name  = "searchdev.ciena.com"
      default_backend_http_settings_name = "searchdev.ciena.com"

      path_rules = [{
        name                       = "searchdev.ciena.com"
        paths                      = ["/*"]
        backend_address_pool_name  = "searchdev.ciena.com"
        backend_http_settings_name = "searchdev.ciena.com"
        }
      ]
    },
    {
      name                               = "searchdev.ciena.com-pathmap-http"
      default_backend_address_pool_name  = "searchdev.ciena.com"
      default_backend_http_settings_name = "searchdev.ciena.com"

      path_rules = [{
        name                       = "searchdev.ciena.com"
        paths                      = ["/*"]
        redirect_configuration_name = "searchdev.ciena.com-redirect"
        }
      ]
    },
    {
      name                               = "searchdev.ciena.com-pathmap-http-5672"
      default_redirect_configuration_name = "searchdev.ciena.com-redirect"

      path_rules = [{
        name                       = "searchdev.ciena.com"
        paths                      = ["/*"]
        redirect_configuration_name = "searchdev.ciena.com-redirect"
        }
      ]
    }
  ]


  # List of Health probes.  Using the health probes, Azure Application Gateway monitors the health of the resources in the back-end pool.
  health_probes = [
    {
      name                = "productgroupapiinternaldev.cs.ciena.com-probe"
      host                = "productgroupapiinternaldev.cs.ciena.com"
      path                = "/"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3
      protocol            = "Https"
    },
    {
      name                = "mcadev.cs.ciena.com-probe"
      host                = "mcadev.cs.ciena.com"
      path                = "/swagger/index"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3
      protocol            = "Https"
    },
    {
      name                = "searchdev.ciena.com-probe"
      host                = "searchdev.ciena.com"
      path                = "/"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3
      protocol            = "Http"
    }
  ]

  # Diangnostic setting
  log_analytics_workspace_resource_group_name = "apps-azuremonitor-dev-e2-rg"
  log_retention_days                          = 5
  log_analytics_workspace_name                = "apps-dev-azuremonitor"
  
  # A list with a single user managed identity id to be assigned to access Keyvault
  identity_ids = ["${azurerm_user_assigned_identity.agw.id}"]

  depends_on = [
    azurerm_key_vault_access_policy.agw_managed_identity

  ]

}

````

## References
