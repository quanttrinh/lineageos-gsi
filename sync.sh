#!/bin/bash
set -eou pipefail

ROOT = "$(dirname "$0")"
cd "$ROOT"

git submodule sync --recursive
git submodule update --init --recursive
mkdir -p lineage
cd lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs
for f in "$ROOT"/local_manifests/*.xml; do
  ln -s ../"$f" .repo/local_manifests/"$(basename "$f")"
done
repo sync -c -j$(nproc --all)  --optimized-fetch --no-tags --no-clone-bundle --prune
