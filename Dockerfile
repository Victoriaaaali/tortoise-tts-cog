# Use an official CUDA image as a parent image
FROM nvidia/cuda:11.7-cudnn8-devel-ubuntu20.04

# Set up Python environment
RUN apt-get update && apt-get install -y python3.9 python3.9-dev python3-pip

# Install Python dependencies
RUN pip3 install torch==1.13.1+cu117 torchaudio==0.12.0 transformers==4.21.0

# Install additional system dependencies
RUN apt-get install -y libsndfile-dev ffmpeg

# Install your model's specific dependencies
RUN pip3 install -e 'git+https://github.com/neonbjb/tortoise-tts#egg=TorToiSe'

# Download model files
RUN mkdir -p /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/autoregressive.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/classifier.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/clvp2.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/cvvp.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/diffusion_decoder.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/vocoder.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/rlg_auto.pth' -P /root/.cache/tortoise/models/ && \
    wget -c 'https://huggingface.co/jbetker/tortoise-tts-v2/resolve/main/.models/rlg_diffuser.pth' -P /root/.cache/tortoise/models/

# Set up the working directory
WORKDIR /root

# Define entrypoint
CMD ["python3"]
