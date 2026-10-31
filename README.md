<img src="packaging/icons/hicolor/128x128/apps/tiktok-live-native.png" alt="" width="96" align="right">

# TikTok LIVE Native for Linux

Native Linux application to broadcast directly to **TikTok LIVE**: full screen or window, camera, microphone, and desktop audio, with live preview, translucent chat overlay, and local recording. Stream directly with its internal engine or with **integrated OBS Studio**, fully configured. No Wine, no virtual machines, and no TikTok LIVE Studio required.

> Independent, **unofficial** project, not affiliated with TikTok or ByteDance. It securely reuses the active web session of your own account from your browser (Firefox, Chrome, or any Chromium-based browser); your account must have TikTok LIVE access enabled.

## Features

- **Sources:** Full screen or individual window (Desktop Portal + PipeWire), V4L2 camera with selectable resolution, microphone, and desktop audio mixed.
- **Formats:** Vertical 720×1280, Vertical 1080×1920, Horizontal 1920×1080, at 25 / 30 / 60 FPS without distortion.
- **Picture-in-Picture Camera:** Drag-and-drop camera positioning directly in the preview, mouse scroll wheel to resize, corner snap buttons. Editable live while streaming.
- **TikTok Integration:** LIVE title support, confirmation before broadcasting, room created only when starting the LIVE, automatic reconnection, and clean room termination when stopped.
- **Chat & Viewers:** In-app docked chat panel and a **translucent always-on-top overlay chat** that can be moved, resized, or hidden. Real-time official viewer count.
- **Recording:** Optional **MP4** recording: exact copy of the broadcast saved to `~/Videos/TikTok LIVE/` (fragmented MP4 playable even if interrupted).
- **Integrated OBS Studio:** Choose between broadcasting with the app's native engine or launching OBS Studio directly with identical scenes, settings, and RTMP credentials already configured.
- **Data for OBS:** Easily obtain the RTMP Server URL and Stream Key to paste into your own custom OBS setup.
- **Local Test:** 8-second local recording test without connecting to TikTok.

## How It Works

```
screen / window (portal → PipeWire) ─┐
camera (V4L2) ───────────────────────┤ compositor ─┬─ preview
mic + desktop audio ─── mixer       │              ├─ H.264 (x264) ─┐
                                    │              └────────────────┴─ FLV → TikTok RTMP
                                    └─────────────────────────────────┴─ MP4 (recording)
```

All video and audio processing is powered by GStreamer. The RTMP push URL and stream key are retrieved using your active web session from Chrome, Chromium, Firefox, or any supported browser.

## Privacy & Security

- Cookies are read from a temporary in-memory copy of your browser's profile and never stored.
- RTMP URLs and stream keys are masked as `***` in all logs.
- Stream keys are scrubbed from disk as soon as OBS exits.

## Running from Source (Debian 13 / Ubuntu 24.04+)

### 1. Install Dependencies

```bash
sudo apt update
sudo apt install -y python3-gi python3-requests python3-cryptography \
  gir1.2-gtk-4.0 gir1.2-adw-1 gir1.2-webkit-6.0 gir1.2-soup-3.0 \
  gir1.2-gst-plugins-base-1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
  gstreamer1.0-pipewire gstreamer1.0-pulseaudio pulseaudio-utils obs-studio
```

### 2. Audio Setup (Cloud VM / Headless)

If running in a headless or cloud VM without physical sound cards, configure PulseAudio with virtual sinks:

```bash
sudo apt install -y pulseaudio pavucontrol
pulseaudio --start
```

### 3. Run

```bash
./run.sh          # Launch the app
./test.sh         # Run local tests (does not contact TikTok)
```

## Repository Structure

| File | Description |
|---|---|
| `app.py` | GTK4 / libadwaita graphical interface |
| `engine.py` | GStreamer engine: capture, composition, encoding, RTMP, audio routing |
| `tiktok.py` | Browser cookie discovery, room creation, RTMP key retrieval |
| `obs_launcher.py` | Automatic OBS profile, scene generation, and launch |
| `chat_overlay.py` | Translucent always-on-top chat overlay |
| `av_test.py` | CLI A/V diagnostic tool |
| `packaging/` | AppImage packaging and build scripts |

## License

[MIT](LICENSE). Unofficial community project; TikTok is a trademark of ByteDance Ltd.
