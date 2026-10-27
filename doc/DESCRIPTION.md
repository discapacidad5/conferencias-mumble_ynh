**Conferencias** is an ultra-lightweight voice and moderated 9-seat conferencing platform designed for slow mobile connections (2G/3G/4G) and servers without a public IP.

### Features

- **Own reliable voice protocol**: a single Go binary serves the web app, the WebSocket transport and the voice history — no external voice server required. Speech is archived per-phrase on the server; if a client drops or disconnects, it downloads the phrases it missed over plain HTTP — nothing is ever lost.
- **Exclusive floor (PTT)**: only one person speaks at a time, with configurable interruption timers per role (admin, host, "La Palabra", regular user) — like Zello.
- **Voice notes in the chat history**: every intervention is stored as a replayable voice note inside the room's chat.
- **Zero WebRTC/ICE/TURN failures on mobile data**: mobile browsers connect over a single HTTPS/443 WebSocket tunnel with Voice Activity Detection (VAD, 0 bytes/s when silent).
- **Lightweight 240p Video for Seat 1 (Host) and Active Speaker ("La Palabra")**: Up to 2 simultaneous low-bandwidth cameras with zero server CPU transcoding and automatic frame dropping for slow 3G/2G listeners.
- **Moderated 9-Seat Room & Breakout Rooms**: Seat reservations, waiting queue, hand raising, timed speaking turns, live voting, collaborative whiteboard, and shared documents (PDF/images/audio/video).
