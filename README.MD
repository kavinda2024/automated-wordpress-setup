# Automated WordPress LAMP VM (Vagrant)

This project automates the setup of a complete **WordPress website** running on a **LAMP stack** using **Vagrant**.  
All provisioning (Apache, MySQL, PHP, and WordPress installation) is handled directly inside the `Vagrantfile`.

## 🚀 Features
- One-command WordPress setup (`vagrant up`)
- Automated LAMP installation via inline shell provisioning
- Configures database, WordPress files, and permissions
- Fully reproducible development environment

## 🧩 Tech Stack
Vagrant · VirtualBox · Ubuntu · Apache · MySQL · PHP · WordPress · Bash

## ⚙️ Usage
```bash
git clone https://github.com/kavinda2024/automated-wordpress-setup.git
cd automated-wordpress-setup
vagrant up
