ARG UBUNTU_VERSION=22.04
ARG CUDA_VERSION=12.6.1
ARG BASE_CUDA_DEVEL_CONTAINER=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}
ARG BASE_CUDA_RUNTIME_CONTAINER=nvidia/cuda:${CUDA_VERSION}-runtime-ubuntu${UBUNTU_VERSION}

FROM ${BASE_CUDA_DEVEL_CONTAINER} AS builder
WORKDIR /app

EXPOSE 3000

# Install dependencies
RUN set -xe \
 && apt update -q \
 && apt install -fy \
        bash git cmake curl time \
        python3 python3-pip \
 && apt clean

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --upgrade clip-api-service
RUN pip install --no-cache-dir --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

# Copy sources
COPY . .
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
