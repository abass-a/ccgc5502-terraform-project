# CCGC 5502 - Terraform Azure Infrastructure Project

**Author:** Abass Ajibola  
**Student ID:** N01134727  
**Course:** CCGC 5502 - Automation and Configuration Management  

---

## Project Overview
This project provisions a modular, multi-tier Azure cloud architecture using HashiCorp Terraform. The infrastructure deploys:
- **Resource Groups & Networking:** Custom VNet, subnets, and Network Security Groups.
- **Compute:** 3x Linux Virtual Machines (with custom extensions and monitoring) and 1x Windows Virtual Machine in high-availability configurations.
- **Load Balancing:** Azure Load Balancer with frontend public IP, health probes, backend address pools, and load balancing rules.
- **Data & Storage:** Managed OS and data disks, Azure Recovery Services Vault, and an Azure Database for PostgreSQL flexible server.
- **Observability:** Centralized Log Analytics Workspace and Azure Network Watcher integration.

## Module Structure
- `modules/rgroup-n4727`: Resource group provisioning
- `modules/network-n4727`: Virtual network, subnet, and NSG rules
- `modules/common-n4727`: Log Analytics workspace, Recovery Services vault, storage account
- `modules/vmlinux-n4727`: 3 Linux VMs, public IPs, NICs, and monitoring extensions
- `modules/vmwindows-n4727`: Windows VM, availability set, and antimalware extension
- `modules/datadisk-n4727`: Managed data disks and VM attachments
- `modules/loadbalancer-n4727`: Azure Load Balancer, backend pool, and probe configuration
- `modules/database-n4727`: Azure PostgreSQL Flexible Server

## Verification & Compliance
- **Resource Count:** Exactly 48 resources tracked in Terraform state (`terraform state list | nl`).
- **Naming Standard:** All resources prefixed with Humber ID suffix `n4727`.
- **Standardized Tags:** Applied across all modules via root locals:
  - `Project`: CCGC 5502 Terraform Project
  - `Name`: abass.ajibola
  - `ExpirationDate`: 2027-12-31
  - `Environment`: Learning
