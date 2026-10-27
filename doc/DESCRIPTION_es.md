**Conferencias** es una plataforma ultraligera de conferencias con 9 asientos moderados diseñada para conexiones móviles lentas (2G/3G/4G) y servidores sin IP pública.

### Características principales

- **Protocolo de voz propio y confiable**: un solo binario Go sirve la web, el WebSocket y el historial de voz — sin servidor de voz externo. Cada frase se archiva en el servidor como segmento; si el cliente tiene microcortes o se desconecta, al volver descarga por HTTP las frases que le faltan — nada se pierde.
- **Piso exclusivo (PTT)**: solo una persona habla a la vez, con tiempos de interrupción configurables por rol (administrador, anfitrión, La Palabra, usuario) — estilo Zello.
- **Notas de voz en el historial del chat**: cada intervención queda guardada como nota de voz re-escuchable dentro del chat de la sala.
- **Cero fallos de conexión en datos móviles**: los navegadores se conectan por un único túnel WebSocket sobre HTTPS (puerto 443) sin requerir UDP ni TURN, con Detector de Actividad de Voz (0 bytes/s en silencio).
- **Cámara ligera 240p en Asiento 1 (Anfitrión) y La Palabra**: máximo 2 cámaras simultáneas de bajo consumo sin recodificación en CPU y con descarte inteligente de cuadros para no cortar jamás el audio en redes 3G/2G.
- **9 asientos moderados y salas de discusión**: cola de espera, levantar la mano, palabra con temporizador, votaciones, pizarra colaborativa, chat y documentos compartidos.
