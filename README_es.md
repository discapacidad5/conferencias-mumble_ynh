# Conferencias Mumble para YunoHost

*[Read this README in English.](./README.md)*

> *Este paquete te permite instalar **Conferencias Mumble** de forma rápida y sencilla en un servidor YunoHost.*  
> *Si aún no tienes YunoHost, consulta [la guía de instalación](https://yunohost.org/install).*

## Descripción general

**Conferencias Mumble** es una plataforma ultraligera de conferencias con 9 asientos moderados, área de palabra con temporizador, salas de discusión, pizarra y documentos compartidos, diseñada para funcionar sin fallos en conexiones móviles lentas (2G/3G/4G) y detrás de Cloudflare Tunnel (sin IP pública ni puertos UDP/TURN en el celular). Conecta la voz con un servidor **Mumble** local o público remoto y transmite cámara ligera de 240p exclusivamente para el Asiento 1 (Anfitrión) y quien tiene La Palabra sobre HTTPS/443.

**Versión incluida:** 1.0.0~ynh1

## Instalación en YunoHost

[![Instalar Conferencias Mumble con YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](#desde-la-interfaz-web-de-yunohost-recomendado)

### Desde la interfaz web de YunoHost (recomendado)

1. Entra a tu webadmin → **Aplicaciones → + Instalar**.
2. Baja hasta el final del catálogo y pega la URL en el campo **"Aplicación personalizada"**:

```text
https://github.com/discapacidad5/conferencias-mumble_ynh
```

3. Completa el formulario (dominio, administrador, contraseña, modo Mumble) e instala.

### Desde la línea de comandos (SSH)

```bash
sudo yunohost app install https://github.com/discapacidad5/conferencias-mumble_ynh
```

### Actualizar la aplicación

```bash
sudo yunohost app upgrade conferencias-mumble -u https://github.com/discapacidad5/conferencias-mumble_ynh
```
