# sri123 FLUX LoRA Training

A personal LoRA model trained on my face using FLUX.1 Dev for generating realistic photos.

## Setup & Process

### Hardware Used
- Training: Vast.ai RTX 4090 24GB VRAM
- Inference: Apple M4 Pro 24GB (Draw Things)

### Stack
- Base model: FLUX.1 Dev (5-bit quantized)
- Training framework: ai-toolkit by ostris
- Inference: Draw Things (Mac)
- Dataset: 21 images + 21 caption files

## Step by Step Process

### 1. Dataset Preparation
- Collected 21 photos with variety in expressions, angles, lighting
- Resized all to 1024x1024 using ImageMagick
- Renamed to sri123_001.jpg format
- Wrote detailed captions for each image as .txt files

### 2. Training
- Platform: Vast.ai RTX 4090 (~$0.42/hr)
- Framework: ostris/ai-toolkit
- Steps: 2000
- Rank: 16
- Learning rate: 0.0004
- Total cost: ~$0.50
- Training time: ~1 hour

### 3. Inference
- Load FLUX.1 Dev 5-bit in Draw Things
- Import sri123_lora.safetensors
- Trigger word: sri123
- LoRA strength: 0.8

## Prompts

### Positive Prompt
sri123, young indian male, short dark black wavy hair with volume on top, wheatish brown skin, sharp defined jawline, high cheekbones, slim face, dark brown almond eyes, straight nose, clean shaven, slim athletic build, age 19-22, wearing a navy blue shirt, standing outdoors, natural daylight, bokeh background, shot on Sony A7R V 85mm f1.4, photorealistic, looking at camera, portrait photography
### Negative Prompt
deformed, ugly, bad anatomy, disfigured, poorly drawn face, mutation, extra limbs, missing limbs, blur, out of focus, text on clothing, blurry, old, fat, glasses, beard, moustache, bald, long hair, feminine, crossbody bag, looking away, sunglasses, hat, low quality, cartoon, anime, painting, illustration, duplicate
## Draw Things Settings
- Model: FLUX.1 Dev 5-bit
- Steps: 35
- Guidance: 4.0
- Resolution: 1024x1024
- Sampler: DDIM Trailing
- LoRA weight: 1.0
- Network scale: 0.8

## Results
Sample images in /samples folder
