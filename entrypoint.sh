#!/bin/bash

cd "$(dirname "$0")"

[ "x$CLIP_MODEL" = "x" ] && export CLIP_MODEL="openai/clip-vit-base-patch16"

clip-api-service serve --model-name=$CLIP_MODEL
