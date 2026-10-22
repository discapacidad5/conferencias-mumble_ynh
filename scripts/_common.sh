#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

UPSTREAM_REPO="https://github.com/discapacidad5/conferencias-mumble.git"

_setup_app_sources() {
    mkdir -p "$install_dir" "$data_dir/docs"

    local tmp_clone
    tmp_clone=$(mktemp -d)
    git clone --depth 1 "$UPSTREAM_REPO" "$tmp_clone"

    for item in main.go mumble.go state.go store.go go.mod go.sum web LICENSE README.md; do
        if [ -e "$tmp_clone/$item" ]; then
            rm -rf "$install_dir/$item"
            cp -a "$tmp_clone/$item" "$install_dir/$item"
        fi
    done

    ynh_safe_rm "$tmp_clone"
}

_build_app() {
    chown -R "$app:$app" "$install_dir" "$data_dir"

    pushd "$install_dir" >/dev/null
        ynh_hide_warnings ynh_exec_as_app env \
            PATH="$PATH" \
            HOME="$install_dir" \
            GOCACHE="$install_dir/.cache/go-build" \
            GOPATH="$install_dir/.go" \
            CGO_ENABLED=0 \
            go build -ldflags="-s -w" -o "$install_dir/conferencia-mumble" .
        ynh_safe_rm "$install_dir/.cache"
        ynh_safe_rm "$install_dir/.go"
    popd >/dev/null

    chown -R "$app:$app" "$install_dir" "$data_dir"
    chmod 750 "$install_dir" "$data_dir"
    chmod +x "$install_dir/conferencia-mumble"
}
