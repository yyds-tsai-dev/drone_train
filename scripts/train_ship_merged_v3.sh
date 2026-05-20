#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

uv run yolo detect train data=data/data.yaml model=yolov8n.pt epochs=50 imgsz=640 batch=16 name=ship_merged_v3
