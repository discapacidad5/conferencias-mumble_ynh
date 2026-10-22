#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

UPSTREAM_REPO="https://github.com/discapacidad5/conferencias-mumble.git"

# En YunoHost, la variable $password (type="password") solo existe durante
# install y no se guarda en settings.yml; en upgrade/config/change_url usamos
# un valor de respaldo (el hash real ya quedó persistido en $data_dir/datos.json).
admin_pwd="${password:-admin123}"

_setup_app_sources() {
    mkdir -p "$install_dir" "$data_dir/docs"

    local tmp_clone
    tmp_clone=$(mktemp -d)
    git clone --quiet --depth 1 "$UPSTREAM_REPO" "$tmp_clone"

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

_stabilize_cloudflared_tunnel() {
    if systemctl list-unit-files 2>/dev/null | grep -q '^cloudflared\.service'; then
        mkdir -p /etc/systemd/system/cloudflared.service.d
        cat > /etc/systemd/system/cloudflared.service.d/http2.conf <<'EOF'
[Service]
Environment="TUNNEL_TRANSPORT_PROTOCOL=http2"
Environment="TUNNEL_EDGE_IP_VERSION=4"
EOF
        systemctl daemon-reload 2>/dev/null || true
        systemctl restart cloudflared 2>/dev/null || true
    fi
}
