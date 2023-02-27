# Introduction

This activity is used to implement the given infrastructure as code:
![Architecture diagram](./resources/architecture-diagram.png)

This is achieved by using Terraform to provision the infrastructure in Azure.

# Branching strategy

The branching strategy used in this repository is based on the [Github Flow](https://guides.github.com/introduction/flow/). This means that the `main` branch is the main branch and all changes are merged into it. The `main` branch is protected and requires a pull request to be merged into it. The pull request must be approved by at least one reviewer before it can be merged.

# Getting Started

This project divides the infrastructure into global resources (used by all environments) like resource groups or storage accounts. There are also modules and an staging environment.

1. Create the global resources using the terraform `terraform apply` command.
   1. Create the resource group for the global resources using the terraform `terraform apply` command in the `global/resource-group` folder.
   2. Create the storage account for the global resources (terraform state will be store here) using the terraform `terraform apply` command in the `global/storage-account` folder.

# Build and Test

TODO: Describe and show how to build your code and run the tests.
