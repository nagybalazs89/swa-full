resource "github_repository" "this" {
  name                      = var.repository_name
  description               = var.repository_description
  visibility                = "public"

  template {
    owner                   = var.template_repository_owner
    repository              = var.template_repository_name
    include_all_branches    = true
  }
}

resource "github_branch" "development" {
    for_each                = var.environment_branches
    repository              = github_repository.this.name
    branch                  = each.key
    depends_on              = [ github_repository_file.github_workflow ]
}

data "github_branch" "main" {
  repository                = github_repository.this.name
  branch                    = var.default_branch
}

resource "github_repository_file" "github_workflow" {
  repository                = github_repository.this.name
  branch                    = data.github_branch.main.branch
  file                      = ".github/workflows/azure-static-web-apps.yml"
  content                   = file("${path.module}/${trimprefix(var.workflow_file_path, "/")}")
  commit_message            = var.workflow_file_commit.commit_message  # "Add Azure Static Web Apps Workflow file"
  commit_author             = var.workflow_file_commit.commit_author   # "terraform"
  commit_email              = var.workflow_file_commit.commit_email    # "terraform@example.com"
  overwrite_on_create       = true
  depends_on                = [ github_actions_secret.az_api_key ]
}