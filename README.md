# Conferencias Mumble for YunoHost

*[Leer este README en español.](./README_es.md)*

> *This package allows you to install **Conferencias Mumble** quickly and simply on a YunoHost server.*  
> *If you don't have YunoHost, please consult [the guide](https://yunohost.org/install) to learn how to install it.*

## Overview

**Conferencias Mumble** is an ultra-lightweight voice and moderated 9-seat conferencing platform built for slow mobile connections (2G/3G/4G) and servers behind CGNAT or Cloudflare Tunnel (zero UDP/TURN ports required for mobile browsers). It bridges room audio with a local or public remote **Mumble** server and streams lightweight 240p video exclusively for Seat 1 (Host) and the active Speaker ("La Palabra") over standard HTTPS/443.

**Shipped version:** 1.0.0~ynh1

## Installing on YunoHost

[![Install Conferencias Mumble with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](#from-the-yunohost-webadmin-recommended)

### From the YunoHost Webadmin (recommended)

1. Open your webadmin → **Applications → + Install**.
2. Scroll to the bottom of the catalog and paste the URL into the **"Custom app"** field:

```text
https://github.com/discapacidad5/conferencias-mumble_ynh
```

3. Fill in the form (domain, administrator, password, Mumble mode) and install.

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
