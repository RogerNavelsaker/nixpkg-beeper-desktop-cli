# Beeper Desktop CLI (Nix)

This repository packages the upstream prebuilt linux-x64 binary of the [Beeper CLI](https://github.com/beeper/cli) (`beeper`). Supported system: `x86_64-linux`. Version syncs from `beeper/cli` GitHub releases via `.nixpkg-sync.json`.

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
