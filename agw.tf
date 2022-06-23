#---------------------------
# Local declarations
#---------------------------
locals {
  
  frontend_ip_configuration_name_public   = "appGwPublicFrontendIp"
  frontend_ip_configuration_name_private  = "appGwPrivateFrontendIp"
  gateway_ip_configuration_name           = "my-gateway-ip-configuration"

  default = {
    request_timeout               = 600
    #return_codes                  = ["200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300", "301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "313", "314", "315", "316", "317", "318", "319", "320", "321", "322", "323", "324", "325", "326", "327", "328", "329", "330", "331", "332", "333", "334", "335", "336", "337", "338", "339", "340", "341", "342", "343", "344", "345", "346", "347", "348", "349", "350", "351", "352", "353", "354", "355", "356", "357", "358", "359", "360", "361", "362", "363", "364", "365", "366", "367", "368", "369", "370", "371", "372", "373", "374", "375", "376", "377", "378", "379", "380", "381", "382", "383", "384", "385", "386", "387", "388", "389", "390", "391", "392", "393", "394", "395", "396", "397", "398", "399", "400", "401", "402", "403", "404", "405", "406", "407", "408", "409", "410", "411", "412", "413", "414", "415", "416", "417", "418", "419", "420", "421", "422", "423", "424", "425", "426", "427", "428", "429", "430", "431", "432", "433", "434", "435", "436", "437", "438", "439", "440", "441", "442", "443", "444", "445", "446", "447", "448", "449", "450", "451", "452", "453", "454", "455", "456", "457", "458", "459", "460", "461", "462", "463", "464", "465", "466", "467", "468", "469", "470", "471", "472", "473", "474", "475", "476", "477", "478", "479", "480", "481", "482", "483", "484", "485", "486", "487", "488", "489", "490", "491", "492", "493", "494", "495", "496", "497", "498", "499", "500", "501", "502", "503", "504", "505", "506", "507", "508", "509", "510", "511", "512", "513", "514", "515", "516", "517", "518", "519", "520", "521", "522", "523", "524", "525", "526", "527", "528", "529", "530", "531", "532", "533", "534", "535", "536", "537", "538", "539", "540", "541", "542", "543", "544", "545", "546", "547", "548", "549", "550", "551", "552", "553", "554", "555", "556", "557", "558", "559", "560", "561", "562", "563", "564", "565", "566", "567", "568", "569", "570", "571", "572", "573", "574", "575", "576", "577", "578", "579", "580", "581", "582", "583", "584", "585", "586", "587", "588", "589", "590", "591", "592", "593", "594", "595", "596", "597", "598", "599", "600", "601", "602", "603", "604", "605", "606", "607", "608", "609", "610", "611", "612", "613", "614", "615", "616", "617", "618", "619", "620", "621", "622", "623", "624", "625", "626", "627", "628", "629", "630", "631", "632", "633", "634", "635", "636", "637", "638", "639", "640", "641", "642", "643", "644", "645", "646", "647", "648", "649", "650", "651", "652", "653", "654", "655", "656", "657", "658", "659", "660", "661", "662", "663", "664", "665", "666", "667", "668", "669", "670", "671", "672", "673", "674", "675", "676", "677", "678", "679", "680", "681", "682", "683", "684", "685", "686", "687", "688", "689", "690", "691", "692", "693", "694", "695", "696", "697", "698", "699", "700", "701", "702", "703", "704", "705", "706", "707", "708", "709", "710", "711", "712", "713", "714", "715", "716", "717", "718", "719", "720", "721", "722", "723", "724", "725", "726", "727", "728", "729", "730", "731", "732", "733", "734", "735", "736", "737", "738", "739", "740", "741", "742", "743", "744", "745", "746", "747", "748", "749", "750", "751", "752", "753", "754", "755", "756", "757", "758", "759", "760", "761", "762", "763", "764", "765", "766", "767", "768", "769", "770", "771", "772", "773", "774", "775", "776", "777", "778", "779", "780", "781", "782", "783", "784", "785", "786", "787", "788", "789", "790", "791", "792", "793", "794", "795", "796", "797", "798", "799", "800", "801", "802", "803", "804", "805", "806", "807", "808", "809", "810", "811", "812", "813", "814", "815", "816", "817", "818", "819", "820", "821", "822", "823", "824", "825", "826", "827", "828", "829", "830", "831", "832", "833", "834", "835", "836", "837", "838", "839", "840", "841", "842", "843", "844", "845", "846", "847", "848", "849", "850", "851", "852", "853", "854", "855", "856", "857", "858", "859", "860", "861", "862", "863", "864", "865", "866", "867", "868", "869", "870", "871", "872", "873", "874", "875", "876", "877", "878", "879", "880", "881", "882", "883", "884", "885", "886", "887", "888", "889", "890", "891", "892", "893", "894", "895", "896", "897", "898", "899", "900", "901", "902", "903", "904", "905", "906", "907", "908", "909", "910", "911", "912", "913", "914", "915", "916", "917", "918", "919", "920", "921", "922", "923", "924", "925", "926", "927", "928", "929", "930", "931", "932", "933", "934", "935", "936", "937", "938", "939", "940", "941", "942", "943", "944", "945", "946", "947", "948", "949", "950", "951", "952", "953", "954", "955", "956", "957", "958", "959", "960", "961", "962", "963", "964", "965", "966", "967", "968", "969", "970", "971", "972", "973", "974", "975", "976", "977", "978", "979", "980", "981", "982", "983", "984", "985", "986", "987", "988", "989", "990", "991", "992", "993", "994", "995", "996", "997", "998", "999"]
    return_codes                  = ["200-999"]

    interval                      = 30
    timeout                       = 30
    unhealthy_threshold           = 3  
  }

}

#---------------------------
# Resource Group, VNet, Subnet selection & Random Resources
#---------------------------
data "azurerm_resource_group" "rgrp" {
  name  = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.vnet_resource_group_name == null ? var.resource_group_name : var.vnet_resource_group_name
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_log_analytics_workspace" "logws" {
  count               = var.log_analytics_workspace_name != null ? 1 : 0
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_storage_account" "storeacc" {
  count               = var.storage_account_name != null ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group
}


data "azurerm_key_vault" "ssl_key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "ciena" {
  name         = var.cert_name_ciena
  key_vault_id = data.azurerm_key_vault.ssl_key_vault.id
}


data "azurerm_key_vault_secret" "cs-ciena" {
  name         = var.cert_name_cs_ciena
  key_vault_id = data.azurerm_key_vault.ssl_key_vault.id
}


#-----------------------------------
# Public IP for application gateway
#-----------------------------------
resource "azurerm_public_ip" "pip" {
  name                = var.app_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

#----------------------------------------------
# Application Gateway with optional blocks
#----------------------------------------------
resource "azurerm_application_gateway" "main" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  tags                = var.tags

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.autoscale_configuration == null ? var.sku.capacity : null
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration != null ? [var.autoscale_configuration] : []
    content {
      min_capacity = lookup(autoscale_configuration.value, "min_capacity")
      max_capacity = lookup(autoscale_configuration.value, "max_capacity")
    }
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = data.azurerm_subnet.snet.id
  }

  frontend_ip_configuration {
    name                          = local.frontend_ip_configuration_name_public
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  frontend_ip_configuration {
    name                          = local.frontend_ip_configuration_name_private
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = "Static"
    subnet_id                     = data.azurerm_subnet.snet.id
  }


 #----------------------------------------------------------
  # frontend port Configuration (Required)
  #----------------------------------------------------------
  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name        = frontend_port.value.name
      port        = frontend_port.value.port
    }
  }


  #----------------------------------------------------------
  # Backend Address Pool Configuration (Required)
  #----------------------------------------------------------
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }


  #----------------------------------------------------------
  # Backend HTTP Settings (Required)
  #----------------------------------------------------------
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      path                                = lookup(backend_http_settings.value, "path", "/")
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 30)
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      host_name                           = lookup(backend_http_settings.value, "host_name", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)

    }
  }


  #----------------------------------------------------------
  # HTTP Listener Configuration (Required)
  #----------------------------------------------------------
  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name_private
      frontend_port_name             = http_listener.value.frontend_port_name
      host_name                      = lookup(http_listener.value, "host_name", null)
      protocol                       = http_listener.value.protocol
      require_sni                    = http_listener.value.ssl_certificate_name != null ? http_listener.value.require_sni : null
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
    }
  }


  #----------------------------------------------------------
  # Request routing rules Configuration (Required)
  #----------------------------------------------------------
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = lookup(request_routing_rule.value, "rule_type", "Basic")
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.redirect_configuration_name == null ? request_routing_rule.value.backend_address_pool_name : null
      backend_http_settings_name  = request_routing_rule.value.redirect_configuration_name == null ? request_routing_rule.value.backend_http_settings_name : null
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      priority                    = request_routing_rule.value.priority
    }
  }

  #----------------------------------------------------------
  # Redirect Configuration (Optional)
  #----------------------------------------------------------
  dynamic "redirect_configuration" {
    for_each = var.redirect_configuration
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = "Permanent"
      target_listener_name = redirect_configuration.value.target_listener_name
      include_path         = true
      include_query_string = true
    }
  }


  #----------------------------------------------------------
  # URL Path Mappings (Optional)
  #----------------------------------------------------------
  dynamic "url_path_map" {
    for_each = var.url_path_maps
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = url_path_map.value.default_redirect_configuration_name == null ? url_path_map.value.default_backend_address_pool_name : null
      default_backend_http_settings_name  = url_path_map.value.default_redirect_configuration_name == null ? url_path_map.value.default_backend_http_settings_name : null
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name", null)

      dynamic "path_rule" {
        for_each = lookup(url_path_map.value, "path_rules")
        content {
          name                        = path_rule.value.name
          backend_address_pool_name   = path_rule.value.backend_address_pool_name
          backend_http_settings_name  = path_rule.value.backend_http_settings_name
          paths                       = flatten(path_rule.value.paths)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
          rewrite_rule_set_name       = lookup(path_rule.value, "rewrite_rule_set_name", null)
          firewall_policy_id          = lookup(path_rule.value, "firewall_policy_id", null)
        }
      }
    }
  }

  
  #----------------------------------------------------------
  # Health Probe
  #----------------------------------------------------------
  dynamic "probe" {
    for_each = var.health_probes
    content {
      name                                      = probe.value.name
      host                                      = lookup(probe.value, "host", "127.0.0.1")
      interval                                  = lookup(probe.value, "interval", 30)
      protocol                                  = probe.value.protocol
      path                                      = lookup(probe.value, "path", "/")
      timeout                                   = lookup(probe.value, "timeout", 30)
      unhealthy_threshold                       = lookup(probe.value, "unhealthy_threshold", 3)

      match {
        # define a local for this big list and put it here.
        status_code = local.default.return_codes
        body        = ""
    }
    }
  }


  #----------------------------------------------------------
  # SSL Certificate (.pfx) Configuration (Optional)
  #----------------------------------------------------------
  ssl_certificate {
    name = "cs.ciena.com"
    data     = data.azurerm_key_vault_secret.cs-ciena.value
    password = ""
  }

  ssl_certificate {
    name     = "ciena.com"
    data     = data.azurerm_key_vault_secret.ciena.value
    password = ""
  }


  #---------------------------------------------------------------
  # Identity block Configuration (Optional)
  # A list with a single user managed identity id to be assigned
  #---------------------------------------------------------------
  dynamic "identity" {
    for_each = var.identity_ids != null ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }
}
  
  #---------------------------------------------------------------
  # azurerm monitoring diagnostics - Application Gateway
  #---------------------------------------------------------------
  resource "azurerm_monitor_diagnostic_setting" "agw-diag" {
    count                      = var.log_analytics_workspace_name != null || var.storage_account_name != null ? 1 : 0
    name                       = lower("agw-${var.app_gateway_name}-diag")
    target_resource_id         = azurerm_application_gateway.main.id
    storage_account_id         = var.storage_account_name != null ? data.azurerm_storage_account.storeacc.0.id : null
    log_analytics_workspace_id = var.log_analytics_workspace_name != null ? data.azurerm_log_analytics_workspace.logws.0.id : null

    dynamic "log" {
      for_each = var.agw_diag_logs
      content {
        category = log.value
        enabled  = true

        retention_policy {
          enabled = false
          days    = var.log_retention_days
        }
      }
    }

    metric {
      category = "AllMetrics"

      retention_policy {
        enabled = false
        days    = var.log_retention_days
      }
    }

    lifecycle {
      ignore_changes = [log, metric]
    }
  }




