#!/usr/bin/env bash
set -e
pulseaudio --start >/dev/null 2>&1 || true
cd "$(dirname "$0")"; mkdir -p logs config
python3 selftest.py >logs/selftest.log 2>&1 || { cat logs/selftest.log; exit 1; }
exec python3 app.py
