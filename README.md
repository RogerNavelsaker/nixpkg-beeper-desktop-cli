# Beeper Desktop CLI (Nix/Flox)

This repository contains a Nix flake and a Flox environment for the [Beeper Desktop CLI](https://github.com/beeper/desktop-api-cli).

## Prerequisites

- [Nix](https://nixos.org/download.html) (with flakes enabled)
- [Flox](https://flox.dev/docs/install/) (optional, for environment management)

## Usage with Nix

Build the CLI:

```bash
nix build .#default
```

Run directly:

```bash
nix run .#default -- --help
```

## Usage with Flox

Activate the environment:

```bash
flox activate
```

The `beeper-desktop-cli` command will be available in your path.
