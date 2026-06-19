# ==============================================================================
# CONFIGURATION DE BASE TERRAFORM - SEANCE 3
# ==============================================================================

# 1. Déclaration des dépendances requises (Le Provider)
# Nous indiquons à Terraform que nous avons besoin du traducteur de fichiers locaux
# ======================================================================
# CONFIGURATION TERRAFORM
# ======================================================================

variable "dns_primary_ip" {
  type        = string
  description = "Adresse IP du serveur de resolution DNS primaire"
  default     = "192.168.56.200"
}

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

resource "local_file" "dns_config" {
  filename = "/tmp/dns_config.txt"
  content  = "nameserver ${var.dns_primary_ip}\nnameserver 8.8.8.8"
}

