variable "static_web_app_location" {
    description         = "Location of the Static Web App resource"
    default             = "West Europe"
    type                = string
}

variable "repository_name" {
    description         = "Name of the repository"
    default             = ""
    type                = string
}

variable "repository_description" {
    description         = "Description of the repository"
    default             = ""
    type                = string
}

variable "template_repository_owner" {
    description         = "Owner of the template repository"
    default             = ""
    type                = string
}

variable "template_repository_name" {
    description         = "Owner of the template repository"
    default             = ""
    type                = string
}

variable "environment_branches" {
    description         = "Branches which will be used as environments"
    default             = {}
    type                = map(string)
}

variable "default_branch" {
    description         = "Default branch (must be exist already)"
    default             = ""
    type                = string
}

variable "workflow_file_path" {
    description         = "Path to the workflow file"
    default             = ""
    type                = string 
}

variable "workflow_file_commit" {
    description         = "Commit details for the workflow file"
    default             = {
        commit_message  = ""
        commit_author   = ""
        commit_email    = ""
    }
    type                = object({
        commit_message  = string
        commit_author   = string
        commit_email    = string
    }) 
}

variable "static_web_app_name" {
    description     = "Name of the Static Web App"
    default         = ""
    type            = string  
}

variable "static_web_app_resource_group_name" {
    description     = "Name of the resource group"
    default         = ""
    type            = string 
}

variable "static_web_app_tier" {
    description     = "Tier of the static web app (Free or Standard)"
    default         = "Standard"
    type            = string
}

variable "workflow_action_time" {
    description     = "Wait time (seconds) for the GitHub build action to run before linked backends are registered"
    type            = number
    default         = 300
}