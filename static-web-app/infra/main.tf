module "static_web_app" {
    source                              = "./modules/static_web_app"
    repository_name                     = var.repository_name
    repository_description              = var.repository_description
    template_repository_owner           = var.template_repository_owner
    template_repository_name            = var.template_repository_name
    environment_branches                = var.environment_branches
    default_branch                      = var.default_branch
    workflow_file_path                  = var.workflow_file_path
    workflow_file_commit                = {
        commit_message                  = var.workflow_file_commit.commit_message
        commit_author                   = var.workflow_file_commit.commit_author
        commit_email                    = var.workflow_file_commit.commit_email
    }
    static_web_app_name                 = var.static_web_app_name
    static_web_app_tier                 = var.static_web_app_tier
    static_web_app_location             = var.static_web_app_location
    static_web_app_resource_group_name  = var.static_web_app_resource_group_name
    workflow_action_time                = var.workflow_action_time

}