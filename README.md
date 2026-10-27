# Conferencias for YunoHost

*[Leer este README en español.](./README_es.md)*

> *This package allows you to install **Conferencias** quickly and simply on a YunoHost server.*  
> *If you don't have YunoHost, please consult [the guide](https://yunohost.org/install) to learn how to install it.*

## Overview

**Conferencias** is an ultra-lightweight voice and moderated 9-seat conferencing platform built for slow mobile connections (2G/3G/4G) and servers behind CGNAT or Cloudflare Tunnel (zero UDP/TURN ports required for mobile browsers). It runs its **own voice protocol** — a single Go binary serving the web app, the WebSocket transport and a per-phrase voice history with client-side gap recovery — plus reliable voice notes in the chat, exclusive floor (PTT) with per-role interruption timers, and lightweight 240p video exclusively for Seat 1 (Host) and the active Speaker ("La Palabra") over standard HTTPS/443.

**Shipped version:** 2.0.0~ynh1

## Installing on YunoHost

[![Install Conferencias with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](#from-the-yunohost-webadmin-recommended)

### From the YunoHost Webadmin (recommended)

1. Open your webadmin → **Applications → + Install**.
2. Scroll to the bottom of the catalog and paste the URL into the **"Custom app"** field:

```text
https://github.com/discapacidad5/conferencias-mumble_ynh
```

3. Fill in the form (domain, administrator, password) and install.

### From the command line (SSH)

```bash
sudo yunohost app install https://github.com/discapacidad5/conferencias-mumble_ynh
```

### Upgrading

```bash
sudo yunohost app upgrade conferencias-mumble -u https://github.com/discapacidad5/conferencias-mumble_ynh
```

## Documentation and resources

- Upstream app code repository: <https://github.com/discapacidad5/conferencias-mumble>
- Official YunoHost documentation: <https://yunohost.org/>
