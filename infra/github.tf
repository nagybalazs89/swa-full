resource "github_repository" "this" {
  name        = "swa-react"
  description = "swa-react"

  visibility = "public"

  template {
    owner                = "nagybalazs89"
    repository           = "swa-react-template"
    include_all_branches = true
  }
}

resource "github_branch" "development" {
    repository = github_repository.this.name
    branch     = "development"
    depends_on = [
      github_repository_file.github_workflow
    ]
}

resource "github_branch" "staging" {
    repository = github_repository.this.name
    branch     = "staging"
    depends_on = [
      github_repository_file.github_workflow
    ]
}

data "github_branch" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_repository_file" "github_workflow" {
  repository          = github_repository.this.name
  branch              = data.github_branch.main.branch
  file                = ".github/workflows/azure-static-web-apps.yml"
  content             = file("${path.module}/templates/azure-static-web-apps.yml")
  commit_message      = "Add Azure Static Web Apps Workflow file"
  commit_author       = "terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [
    github_actions_secret.az_api_key
  ]
}