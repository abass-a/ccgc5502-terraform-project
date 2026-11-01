# CCGC 5502 - Terraform Azure Infrastructure Project

**Author:** Abass Ajibola  
**Student ID:** N01134727  
**Course:** CCGC 5502 - Automation and Configuration Management  

---

## Project Overview

This project provisions a modular, multi-tier enterprise cloud infrastructure on Microsoft Azure using HashiCorp Terraform. The architecture includes:

* **Resource Management & Networking:** Dedicated resource group, Virtual Network (VNet), subnets, and Network Security Groups (NSGs).
* **Compute Layer:** 
  * 3x Linux Virtual Machines configured with network interfaces, public IPs, and Azure Monitor / diagnostic extensions.
  * 1x Windows Virtual Machine configured in an Availability Set with IaaSAntimalware extension.
* **Load Balancing:** Azure Load Balancer with frontend public IP, health probes, backend address pools, and inbound distribution rules across Linux instances.
* **Data & Storage:** 
  * Independent managed OS and data disks attached to all compute instances.
  * Azure Recovery Services Vault configured for backup management.
  * Azure Database for PostgreSQL Flexible Server instance.
* **Observability:** Centralized Log Analytics Workspace and Network Watcher diagnostics.

---

## Module Structure

| Module Directory | Description |
| :--- | :--- |
| `modules/rgroup-n4727` | Provisions central resource group container |
| `modules/network-n4727` | Deploys VNet, subnet, and security rules |
| `modules/common-n4727` | Deploys Log Analytics, Recovery Vault, and Storage Account |
| `modules/vmlinux-n4727` | Deploys 3 Linux VMs, NICs, PIPs, and custom extensions |
| `modules/vmwindows-n4727` | Deploys Windows VM, Availability Set, and Antimalware |
| `modules/datadisk-n4727` | Provisions managed data disks and handles VM attachments |
| `modules/loadbalancer-n4727` | Deploys Azure LB, backend pool associations, and probes |
| `modules/database-n4727` | Deploys PostgreSQL Flexible Server |

---

## Deployment & Verification

### Prerequisites
* Azure CLI authenticated (`az login`)
* Terraform CLI (v1.0+)

### Execution Commands
```bash
# Initialize backend and provider plugins
terraform init

# Validate syntax and configuration integrity
terraform validate

# Review proposed changes
terraform plan

# Apply infrastructure deployment
terraform apply -auto-approve
