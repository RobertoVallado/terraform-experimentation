# Terraform Cheatsheet – Azure Static Web App Repo

### 1️ Initialize Terraform

| Shell                | Command          | Notes                                                  |
| -------------------- | ---------------- | ------------------------------------------------------ |
| Bash / Linux / macOS | `terraform init` | Downloads providers and prepares the working directory |
| PowerShell           | `terraform init` | Same as Bash                                           |

---

### 2️ Validate Terraform Files

| Shell      | Command              | Notes                             |
| ---------- | -------------------- | --------------------------------- |
| Bash       | `terraform validate` | Checks syntax and config validity |
| PowerShell | `terraform validate` | Same                              |

---

### 3️ Plan Deployment

| Shell      | Command          | Notes                        |
| ---------- | ---------------- | ---------------------------- |
| Bash       | `terraform plan` | Shows what Terraform will do |
| PowerShell | `terraform plan` | Same                         |

---

### 4️ Apply Changes

| Shell      | Command           | Notes                                 |
| ---------- | ----------------- | ------------------------------------- |
| Bash       | `terraform apply` | Interactive apply; confirm with `yes` |
| PowerShell | `terraform apply` | Same                                  |

---

### 5️ Pass Variables via CLI

| Shell      | Example                                                                                         | Notes         |
| ---------- | ----------------------------------------------------------------------------------------------- | ------------- |
| Bash       | `terraform apply -var="resource_group_name=rg-prod" -var="static_web_app_name=prod-webapp-001"` | Double quotes |
| PowerShell | `terraform apply -var 'resource_group_name=rg-prod' -var 'static_web_app_name=prod-webapp-001'` | Single quotes |

---

### 6️ Use Environment Variables

| Shell      | Example                                       | Notes                               |
| ---------- | --------------------------------------------- | ----------------------------------- |
| Bash       | `export TF_VAR_resource_group_name="rg-prod"` | Terraform picks it up automatically |
| PowerShell | `$env:TF_VAR_resource_group_name = "rg-prod"` | Same effect                         |

---

### 7️ Common Files to Ignore in Git

```
.terraform/
*.tfstate*
*.tfvars
crash.log
```

* `.terraform/` → provider cache
* `*.tfstate*` → sensitive state
* `*.tfvars` → local variables
* `crash.log` → errors

---

### 8️ Check Outputs

| Shell      | Command            | Notes                                    |
| ---------- | ------------------ | ---------------------------------------- |
| Bash       | `terraform output` | Displays outputs defined in `outputs.tf` |
| PowerShell | `terraform output` | Same                                     |

