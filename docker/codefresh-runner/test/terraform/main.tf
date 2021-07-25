terraform {
  required_version = "~> 0.13.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.51.0"
    }

    google = {
      source  = "hashicorp/google"
      version = ">= 3.76.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.2"
    }

    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.22.0"
    }

    codefresh = {
      source  = "codefresh-io/codefresh"
      version = ">= 0.0.19"
    }
  }
}

provider "aws" {
}

provider "google" {
}

provider "local" {
}

provider "null" {
}

provider "random" {
}

provider "time" {
}

provider "vault" {
}

provider "codefresh" {
}
