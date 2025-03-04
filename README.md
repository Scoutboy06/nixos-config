# NixOS Configuration

This repository contains my NixOS configuration using flakes. Below are the steps to set up and manage this configuration.

## Setup

### 1. Clone the Repository

If you haven't already cloned the repository, do:

```
cd ~
git clone https://github.com/scoutboy06/nixos-config.git
cd nixos-config
```

### 2. Apply the Home Manager Configuration

To apply the Home Manager configuration for user elias:

```
home-manager switch --flake ~/nixos-config#elias
```

If you get a "dirty" flake error, see the troubleshooting section below.

### 3. Apply System Configuration (if applicable)

If this repository also manages your system configuration, apply it with:

```
sudo nixos-rebuild switch --flake ~/nixos-config
```

## Common Commands

### Updating the System

```
nix flake update
sudo nixos-rebuild switch --flake ~/nixos-config
```

### Updating Home Manager Config

```
home-manager switch --flake ~/nixos-config#elias
```

### Checking for Flake Changes

```
git status
```

### Fixing "dirty" flake issues

If you get an error about a dirty repository, do one of the following:

1. Commit your changes (Recommended)

```
git add .
git commit -m "Update configuration"
home-manager switch --flake ~/nixos-config#elias
```

2. Allow dirty flakes (if testing changes)

```
home-manager switch --flake ~/nixos-config#elias --impure
```

3. Stash your changes (if unsure)

```
git stash
home-manager switch --flake ~/nixos-config#elias
git stash pop  # Restore changes later
```
