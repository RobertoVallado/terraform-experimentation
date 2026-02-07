Voici ton README traduit en français, en Markdown :
# Terraform Azure Static Web App

Configuration simple de Terraform pour créer un **groupe de ressources Azure** et une **application web statique**. L’objectif est de rendre le provisionnement de l’infrastructure rapide et réutilisable.

## Fonctionnalités

* Crée un groupe de ressources dans Azure
* Déploie une application web statique avec un nom, un emplacement et un SKU configurables
* Entièrement réutilisable en modifiant les variables
* Utilise `.gitignore` pour garder les fichiers sensibles et générés hors de Git

## Prérequis

* [Terraform](https://www.terraform.io/downloads.html) ≥ 1.3
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
* VS Code (optionnel) avec l’**extension Terraform de Anton Kulikov** pour l’aide à la syntaxe

  > Pourquoi celle-ci ? Je trouve qu’elle est très pratique, bien maintenue et régulièrement mise à jour.

## Démarrage

1. **Se connecter à Azure**

```bash
az login
```

2. **Initialiser Terraform**

```bash
terraform init
```

3. **Configurer les variables**

Vous pouvez créer un fichier `terraform.tfvars` :

```hcl
resource_group_name = "rg-demo-staticweb"
static_web_app_name = "demo-static-webapp-12345"

tags = {
  environment = "dev"
  project     = "demo"
}
```

Ou passer les variables via la CLI :

```bash
terraform apply -var="resource_group_name=rg-prod" -var="static_web_app_name=prod-webapp-001"
```

4. **Planifier et appliquer**

```bash
terraform plan
terraform apply
```

---

## Sorties (Outputs)

Après l’application, Terraform affiche :

* Nom du groupe de ressources
* Nom de l’application web statique
* Nom d’hôte par défaut de l’application web statique

---

## .gitignore

Assurez-vous que les fichiers suivants sont ignorés :

```
.terraform/
*.tfstate*
*.tfvars
crash.log
```

Ces fichiers contiennent des informations sensibles et ne doivent **jamais** être committés.

---

## Notes

* Terraform facilite la réutilisation et la version de votre infrastructure.
* Utiliser l’extension Terraform dans VS Code permet de détecter les erreurs de syntaxe et accélère le codage (très utile pour le debug).

Ceci est un dépôt **simple pour débuter**. Vous pouvez l’étendre avec :

* CI/CD via GitHub Actions pour l’application web statique
* Backends distants pour la gestion de l’état
* Support multi-environnements (dev/stage/prod)

---

## Références Terraform pour ce dépôt

**AzureRM Provider :**
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

**Azure Resource Group** (Documentation pour la ressource `azurerm_resource_group`) :
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

**Azure Static Web App :**
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app)

**Terraform Outputs :**
[https://developer.hashicorp.com/terraform/language/values/outputs](https://developer.hashicorp.com/terraform/language/values/outputs)

**Terraform State :**
[https://developer.hashicorp.com/terraform/language/state](https://developer.hashicorp.com/terraform/language/state)

