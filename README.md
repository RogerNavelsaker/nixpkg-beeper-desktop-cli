# Beeper Desktop CLI (Nix)

This repository contains a Nix flake for the [Beeper Desktop CLI](https://github.com/beeper/desktop-api-cli).

## Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled

## Usage

Build the CLI:

```bash
nix build .#default
```

Run directly:

```bash
nix run .#default -- --help
```
