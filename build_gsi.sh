#!/bin/bash
set -eou pipefail

ROOT = "$(dirname "$0")"
cd "$ROOT"

TARGETS = (
  lineage_arm64_bvNE-bp2a-userdebug
  lineage_arm64_bvN4-bp2a-userdebug
  lineage_arm64_bgNE-bp2a-userdebug
  lineage_arm64_bgN4-bp2a-userdebug
)
TARGET = ${TARGETS[0]} # Default target

case "$1" in
  arm64_bvNE)
    TARGET = ${TARGETS[0]}
    ;;
  arm64_bvN4)
    TARGET = ${TARGETS[1]}
    ;;
  arm64_bgNE)
    TARGET = ${TARGETS[2]}
    ;;
  arm64_bgN4)
    TARGET = ${TARGETS[3]}
    ;;
esac

cd lineage

. ../treble_experimentations/apply-patches.sh .

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_MAXSIZE=50G # 50 GB

. build/envsetup.sh
ccache -M 50G -F 0
breakfast $TARGET
make systemimage -j$(nproc --all)
