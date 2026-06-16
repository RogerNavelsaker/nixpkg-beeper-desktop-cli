#!/usr/bin/env bash
set -euo pipefail

latest_tag=$(curl -s "https://api.github.com/repos/beeper/desktop-api-cli/releases/latest" | jq -r .tag_name)
if [ "$latest_tag" == "null" ] || [ -z "$latest_tag" ]; then
  latest_tag=$(git ls-remote --tags "https://github.com/beeper/desktop-api-cli.git" | awk -F/ '{print $3}' | sort -V | tail -n1)
fi

version=${latest_tag#v}
echo "Updating to version $version..."

hash=$(nix-prefetch-url --unpack "https://github.com/beeper/desktop-api-cli/archive/refs/tags/$latest_tag.tar.gz" 2>/dev/null)
sri_hash=$(nix hash to-sri --type sha256 "$hash")

sed -i "s|version = \".*\"|version = \"$version\"|" flake.nix
sed -i "s|rev = \".*\"|rev = \"$latest_tag\"|" flake.nix
sed -i "s|hash = \"sha256-.*\"|hash = \"$sri_hash\"|" flake.nix

echo "Done."
