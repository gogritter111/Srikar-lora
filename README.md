# Srikar LoRA — FLUX.1 Dev Fine-Tuning for Photorealistic Portrait Generation

A end-to-end personal LoRA model trained on my own face using FLUX.1 Dev, capable of generating highly realistic, photographic-quality portraits in diverse scenes and lighting conditions.

---

## Overview

This project documents the complete pipeline for fine-tuning a FLUX.1 Dev model using LoRA (Low-Rank Adaptation) to generate consistent, photorealistic images of a specific individual. The entire workflow — from dataset preparation to inference — was built and executed independently.

---

## Technical Stack

| Component | Tool |
|---|---|
| Base Model | FLUX.1 Dev (Black Forest Labs) |
| Training Framework | ostris/ai-toolkit |
| Training Hardware | Vast.ai RTX 4090 (24GB VRAM) |
| Inference | Draw Things (Apple M4 Pro, Metal backend) |
| Quantization | 5-bit (inference), bf16 (training) |

---

## Architecture & Approach

### Why FLUX.1 Dev
FLUX.1 Dev uses a flow matching architecture (as opposed to traditional DDPM diffusion) which produces significantly sharper, more photorealistic outputs than Stable Diffusion based models. It uses a hybrid attention mechanism combining multimodal and single-stream transformer blocks, making it particularly well suited for identity-consistent generation.

### Why LoRA
Full fine-tuning of a model the size of FLUX.1 Dev (~24GB) is computationally prohibitive for most use cases. LoRA works by injecting trainable low-rank decomposition matrices into the transformer attention layers, allowing the model to learn new concepts with a fraction of the parameters. Our trained adapter is 165MB vs the ~24GB base model.

### Training Configuration
- **Network rank:** 16 (linear and alpha)
- **Optimizer:** AdamW 8-bit (memory efficient)
- **Learning rate:** 0.0004
- **Steps:** 2000
- **Batch size:** 1 with gradient checkpointing
- **Noise scheduler:** Flow matching
- **Mixed precision:** bf16
- **EMA decay:** 0.99 (exponential moving average for stable convergence)
- **Resolution:** Multi-resolution training (512, 768, 1024)

### Dataset
- 21 carefully curated training images
- Diverse in expression, angle, lighting and background
- All resized to 1024×1024 via center-crop
- Each image paired with a detailed natural language caption including trigger word, physical description, pose, environment and lighting
- Caption dropout rate of 5% to improve unconditional generation

---

## Pipeline
Raw Photos (iPhone)

↓

ImageMagick resize to 1024×1024

↓

Manual caption writing (.txt per image)

↓

Upload to Vast.ai RTX 4090 instance

↓

ai-toolkit LoRA training (2000 steps, ~1hr)

↓

Export sri123_lora.safetensors (165MB)

↓

Import into Draw Things on M4 Pro

↓

Inference via FLUX.1 Dev 5-bit + LoRA
---

## Inference Settings

| Parameter | Value |
|---|---|
| Base model | FLUX.1 Dev 5-bit |
| LoRA strength | 0.8 |
| Steps | 35 |
| Guidance scale | 4.0 |
| Resolution | 1024×1024 |
| Sampler | DDIM Trailing |

### Positive Prompt
sri123, young indian male, short dark black wavy hair with volume on top, wheatish brown skin, sharp defined jawline, high cheekbones, slim face, dark brown almond eyes, straight nose, clean shaven, slim athletic build, age 19-22, wearing a navy blue shirt, standing outdoors, natural daylight, bokeh background, shot on Sony A7R V 85mm f1.4, photorealistic, looking at camera, portrait photography
### Negative Prompt
deformed, ugly, bad anatomy, disfigured, poorly drawn face, mutation, extra limbs, missing limbs, blur, out of focus, text on clothing, blurry, old, fat, glasses, beard, moustache, bald, long hair, feminine, crossbody bag, looking away, sunglasses, hat, low quality, cartoon, anime, painting, illustration, duplicate
---

## Results

Sample outputs are in the `/samples` directory. Key observations:

- Strong identity consistency across varied scenes and lighting
- Photorealistic backgrounds with no AI artifacts
- Natural pose and clothing generation
- Effective response to camera and lens specifications in prompts

---

## Key Learnings

- **FLUX requires significantly lower guidance scale than SD** — values above 4.5 cause oversaturation
- **Flow matching scheduler is critical** — using DDPM schedulers with FLUX produces poor results
- **Caption quality matters more than quantity** — 21 well-captioned images outperforms 50 poorly captioned ones
- **Multi-resolution training** improves generalization across different aspect ratios
- **T4 (14.5GB VRAM) cannot run FLUX LoRA training** — minimum 24GB required even with quantization

---

## Cost

| Resource | Cost |
|---|---|
| Vast.ai RTX 4090 (~1hr) | ~$0.50 |
| Inference (local, M4 Pro) | $0 |
| **Total** | **~$0.50** |

---

## Repository Structure
├── README.md

├── config/

│   ├── sri123_config.yaml    # Training configuration

│   └── resize.sh             # Dataset preprocessing script

├── prompts/

│   └── prompts.md            # Tested prompts and variations

├── dataset/                  # Training images and captions

└── samples/                  # Generated output images
---

## References

- [FLUX.1 — Black Forest Labs](https://blackforestlabs.ai)
- [ai-toolkit by ostris](https://github.com/ostris/ai-toolkit)
- [Draw Things](https://drawthings.ai)
- [LoRA: Low-Rank Adaptation of Large Language Models](https://arxiv.org/abs/2106.09685)
