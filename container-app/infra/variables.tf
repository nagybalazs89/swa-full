variable "prefix" {
    description             = "Prefix of the created resources"
    type                    = string
    default                 = ""
}

variable "resource_group_name" {
    description             = "Given resource group will hold the container app"
    type                    = string
    default                 = "swa-resources"
}

variable "container_app_environment_name" {
    description             = "Name of the container app environment"
    type                    = string 
    default                 = "swa-container-app-environment"
}

variable "image" {
    description             = "Image source for the container"
    type                    = string
    default                 = ""
}

variable "cpu" {
    description             = "CPU size for the contaienr"
    type                    = number
    default                 = 0.25
}

variable "memory" {
    description             = "Size of memory for the container"
    type                    = string
    default                 = "0.5Gi"
}

variable "target_port" {
    description             = "Target port of the container"
    type                    = number
    default                 = 80
}

variable "env" {
    description             = "Map of environment variables"
    type                    = map(string)
    default                 = {}
}