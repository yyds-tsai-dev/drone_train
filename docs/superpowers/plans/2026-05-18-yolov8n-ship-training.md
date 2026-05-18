# YOLOv8n Ship Training Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prepare a CUDA-enabled Python 3.12 YOLOv8 environment with `uv`, version the lightweight project files, and train `yolov8n.pt` on the local ship dataset.

**Architecture:** Keep the dataset local and outside git, while tracking the dataset config, environment files, and docs. Use `uv` to create the Python 3.12 virtualenv and install PyTorch from the CUDA 12.4 wheel index before installing Ultralytics.

**Tech Stack:** Python 3.12, uv, PyTorch CUDA 12.4 wheels, Ultralytics YOLOv8, OpenCV, git.

---

### Task 1: Version-Control Project Metadata

**Files:**
- Create: `.gitignore`
- Create: `docs/superpowers/specs/2026-05-18-yolov8n-ship-training-design.md`
- Create: `docs/superpowers/plans/2026-05-18-yolov8n-ship-training.md`
- Modify: `data/data.yaml`

- [ ] **Step 1: Initialize git if needed**

Run: `git init`
Expected: repository exists at `.git/`.

- [ ] **Step 2: Exclude large local artifacts**

Create `.gitignore` with `.venv/`, `data.zip`, dataset split image/label folders, `runs/`, and model weight outputs excluded.

- [ ] **Step 3: Make dataset paths portable**

Change `data/data.yaml` split paths to:

```yaml
train: train/images
val: valid/images
test: test/images
```

- [ ] **Step 4: Commit project metadata**

Run:

```bash
git add .gitignore data/data.yaml docs/superpowers/specs/2026-05-18-yolov8n-ship-training-design.md docs/superpowers/plans/2026-05-18-yolov8n-ship-training.md
git commit -m "chore: initialize yolov8 training project"
```

Expected: initial commit succeeds.

### Task 2: Create CUDA-Aware Python Environment

**Files:**
- Create: `.venv/`
- Create: `pyproject.toml`
- Create: `uv.lock`

- [ ] **Step 1: Create Python 3.12 virtualenv**

Run: `uv venv --python 3.12 .venv`
Expected: `.venv/bin/python --version` prints `Python 3.12.x`.

- [ ] **Step 2: Define dependencies**

Create `pyproject.toml` with Python 3.12 and dependencies for `torch`, `torchvision`, `ultralytics`, and `opencv-python`, with `torch` and `torchvision` sourced from the official PyTorch CUDA 12.4 index.

- [ ] **Step 3: Install dependencies**

Run: `uv sync`
Expected: `uv.lock` is created and dependencies install into `.venv`.

- [ ] **Step 4: Verify CUDA from Python**

Run:

```bash
uv run python -c "import torch; print(torch.__version__); print(torch.version.cuda); print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'no cuda')"
```

Expected: CUDA availability prints `True` and the GPU name is `NVIDIA L4`.

- [ ] **Step 5: Commit environment files**

Run:

```bash
git add pyproject.toml uv.lock
git commit -m "chore: add uv yolov8 training environment"
```

Expected: commit succeeds.

### Task 3: Run Training

**Files:**
- Read: `data/data.yaml`
- Create: `runs/detect/ship_merged_v3/`

- [ ] **Step 1: Check YOLO CLI**

Run: `uv run yolo version`
Expected: Ultralytics prints its installed version.

- [ ] **Step 2: Start YOLOv8n training**

Run:

```bash
uv run yolo detect train data=data/data.yaml model=yolov8n.pt epochs=50 imgsz=640 batch=16 name=ship_merged_v3
```

Expected: training starts on CUDA and writes output under `runs/detect/ship_merged_v3/`.

- [ ] **Step 3: Preserve training state outside git**

Do not commit `runs/` or `yolov8n.pt`; they are ignored local artifacts.
