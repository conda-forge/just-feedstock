#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --no-track --locked --root "$PREFIX" --path .

# generate completion files
mkdir -p "${PREFIX}/etc/bash_completion.d"
"$PREFIX/bin/just" --completions bash > "${PREFIX}/etc/bash_completion.d/just" || true
mkdir -p "${PREFIX}/share/zsh/site-functions"
"$PREFIX/bin/just" --completions zsh > "${PREFIX}/share/zsh/site-functions/_just" || true
