# Terraform Azure Static Web App

Simple Terraform setup to create an **Azure Resource Group** and a **Static Web App**. The goal is to make infrastructure provisioning quick and reusable.

## Features

* Creates a Resource Group in Azure
* Deploys a Static Web App with configurable name, location, and SKU
* Fully reusable by changing variables
* Uses `.gitignore` to keep sensitive and generated files out of Git



## Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) ≥ 1.3
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
* VS Code (optional) with the **Terraform extension by Anton Kulikov** for syntax help
    >Why that specific one? I think is pretty cool and is well mantained and updated.


## Getting Started

1. **Login to Azure**

```bash
az login
```

2. **Initialize Terraform**

```bash
terraform init
```

3. **Set Variables**

You can create a `terraform.tfvars` file:

```hcl
resource_group_name = "rg-demo-staticweb"
static_web_app_name = "demo-static-webapp-12345"

tags = {
  environment = "dev"
  project     = "demo"
}
```

Or pass variables via CLI:

```bash
terraform apply -var="resource_group_name=rg-prod" -var="static_web_app_name=prod-webapp-001"
```

4. **Plan and Apply**

```bash
terraform plan
terraform apply
```

---

## Outputs

After applying, Terraform outputs:

* Resource Group name
* Static Web App name
* Default hostname of the Static Web App

---

## .gitignore

Make sure the following are ignored:

```
.terraform/
*.tfstate*
*.tfvars
crash.log
```

These files contain sensitive info and should **never** be committed.

## Notes

* Terraform makes it easy to reuse and version your infrastructure.
* Using the VS Code Terraform extension helps catch syntax issues and speeds up coding. (Very helpful for debugging)


This is a **simple starter** repo. You can expand it with:

* GitHub Actions CI/CD for the Static Web App
* Remote backends for state management
* Multi-environment support (dev/stage/prod)

⠀⠀⠀⠀⠀⢀⣤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⢤⣤⣀⣀⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡼⠋⠀⣀⠄⡂⠍⣀⣒⣒⠂⠀⠬⠤⠤⠬⠍⠉⠝⠲⣄⡀⠀⠀
⠀⠀⠀⢀⡾⠁⠀⠊⢔⠕⠈⣀⣀⡀⠈⠆⠀⠀⠀⡍⠁⠀⠁⢂⠀⠈⣷⠀⠀
⠀⠀⣠⣾⠥⠀⠀⣠⢠⣞⣿⣿⣿⣉⠳⣄⠀⠀⣀⣤⣶⣶⣶⡄⠀⠀⣘⢦⡀
⢀⡞⡍⣠⠞⢋⡛⠶⠤⣤⠴⠚⠀⠈⠙⠁⠀⠀⢹⡏⠁⠀⣀⣠⠤⢤⡕⠱⣷
⠘⡇⠇⣯⠤⢾⡙⠲⢤⣀⡀⠤⠀⢲⡖⣂⣀⠀⠀⢙⣶⣄⠈⠉⣸⡄⠠⣠⡿
⠀⠹⣜⡪⠀⠈⢷⣦⣬⣏⠉⠛⠲⣮⣧⣁⣀⣀⠶⠞⢁⣀⣨⢶⢿⣧⠉⡼⠁
⠀⠀⠈⢷⡀⠀⠀⠳⣌⡟⠻⠷⣶⣧⣀⣀⣹⣉⣉⣿⣉⣉⣇⣼⣾⣿⠀⡇⠀Bobs Docs
⠀⠀⠀⠈⢳⡄⠀⠀⠘⠳⣄⡀⡼⠈⠉⠛⡿⠿⠿⡿⠿⣿⢿⣿⣿⡇⠀⡇⠀
⠀⠀⠀⠀⠀⠙⢦⣕⠠⣒⠌⡙⠓⠶⠤⣤⣧⣀⣸⣇⣴⣧⠾⠾⠋⠀⠀⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠙⠶⣭⣒⠩⠖⢠⣤⠄⠀⠀⠀⠀⠀⠠⠔⠁⡰⠀⣧⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠲⢤⣀⣀⠉⠉⠀⠀⠀⠀⠀⠁⠀⣠⠏⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠒⠲⠶⠤⠴⠒⠚⠁