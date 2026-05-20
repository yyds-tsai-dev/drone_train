# YOLOv8n Ship Training Design

## Goal

Train a YOLOv8n object detection model on the local ship dataset in `/nashome/NVL4/vdalab/yyds-dev/drone_train/data` using a Python 3.12 virtual environment managed by `uv`.

## Dataset

The dataset already exists locally with `train`, `valid`, and `test` splits. `data/data.yaml` will use relative split paths so the dataset works when the project directory moves:

- `train: train/images`
- `val: valid/images`
- `test: test/images`

The dataset images, labels, cache files, and `data.zip` are excluded from git because they are large local artifacts.

## Environment

The machine has NVIDIA driver `550.120` and reports CUDA `12.4` through `nvidia-smi`. The environment will use:

- `uv venv --python 3.12 .venv`
- CUDA 12.4 PyTorch wheels from the official PyTorch `cu124` wheel index
- `ultralytics` for the `yolo` CLI
- OpenCV dependency through `opencv-python`

After installation, Python will verify `torch.cuda.is_available()` and print the PyTorch CUDA build string.

## Training Command

Training will run through the `uv` environment:

```bash
uv run yolo detect train data=data/data.yaml model=yolov8n.pt epochs=50 imgsz=640 batch=16 name=ship_merged_v3
```

Outputs will be written under `runs/` and ignored by git.

## Version Control

Git tracks project configuration, environment metadata, and documentation. Large local training artifacts are excluded. The initial commit records the project setup before training starts.
