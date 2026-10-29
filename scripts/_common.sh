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

    # Limpiar fuentes previas: los archivos renombrados o eliminados
    # upstream (p.ej. mumble.go -> media.go) no deben quedar en el build
    find "$install_dir" -maxdepth 1 -name '*.go' -delete
    rm -rf "$install_dir/web" "$install_dir/vendor"

    for item in main.go media.go segmentos.go state.go store.go go.mod go.sum vendor web LICENSE README.md; do
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
            go build -ldflags="-s -w" -o "$install_dir/conferencia" .
        ynh_safe_rm "$install_dir/.cache"
        ynh_safe_rm "$install_dir/.go"
    popd >/dev/null

    chown -R "$app:$app" "$install_dir" "$data_dir"
    chmod 750 "$install_dir" "$data_dir"
    chmod +x "$install_dir/conferencia"
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

# Las apps instaladas fuera del catalogo no tienen icono en el portal de YunoHost.
# Truco oficial de src/app.py de YunoHost: si existe
# /usr/share/yunohost/applogos/$app.png, ese archivo se usa como logo de la app
# en el webadmin (app_info). Para el portal SSO (tiles), app_ssowatconf() lee
# _permissions.main.logo_hash de /etc/yunohost/apps/$app/settings.yml y sirve
# /yunohost/sso/applogos/<sha256>.png: hay que registrar ambos.
_install_app_logo() {
    local logos_dir="/usr/share/yunohost/applogos"
    local src_logo=""
    if [ -f "$install_dir/web/icon-512.png" ]; then
        src_logo="$install_dir/web/icon-512.png"
    elif [ -f "../doc/logo.png" ]; then
        src_logo="../doc/logo.png"
    elif [ -f "../settings/doc/logo.png" ]; then
        src_logo="../settings/doc/logo.png"
    fi
    if [ -n "$src_logo" ]; then
        mkdir -p "$logos_dir" 2>/dev/null || true
        cp -f "$src_logo" "$logos_dir/$app.png" 2>/dev/null || true
        chmod 644 "$logos_dir/$app.png" 2>/dev/null || true

        local logo_hash
        logo_hash=$(sha256sum "$src_logo" | cut -d' ' -f1)
        cp -f "$src_logo" "$logos_dir/$logo_hash.png"
        chmod 644 "$logos_dir/$logo_hash.png" 2>/dev/null || true

        python3 - "$app" "$logo_hash" <<'PYEOF' || true
import sys, yaml
app, logo_hash = sys.argv[1], sys.argv[2]
path = f"/etc/yunohost/apps/{app}/settings.yml"
with open(path) as f:
    settings = yaml.safe_load(f) or {}
settings.setdefault("_permissions", {}).setdefault("main", {})["logo_hash"] = logo_hash
with open(path, "w") as f:
    yaml.safe_dump(settings, f)
PYEOF

        ynh_hide_warnings yunohost app ssowatconf || true
    fi
}

_remove_app_logo() {
    if [ -f "/usr/share/yunohost/applogos/$app.png" ]; then
        local logo_hash
        logo_hash=$(sha256sum "/usr/share/yunohost/applogos/$app.png" | cut -d' ' -f1)
        rm -f "/usr/share/yunohost/applogos/$app.png" "/usr/share/yunohost/applogos/$logo_hash.png"
    fi
}
