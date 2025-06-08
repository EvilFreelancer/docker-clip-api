# Dockerized CLIP API service

This project provides a simple image classification API built using the CLIP family of models. It wraps the
functionality into a Dockerized API service based
on [bentoml/CLIP-API-service](https://github.com/bentoml/CLIP-API-service).

## Features

* Use any Hugging Face-compatible CLIP model
* Accepts images via URL or base64 string
* Ranks a list of textual candidates against a given image
* Dockerized for easy deployment

## Getting Started

### 1. Clone the Repository

```shell
git clone https://github.com/EvilFreelancer/docker-clip-api.git
cd docker-clip-api
cp docker-compose.dist.yml docker-compose.yml
```

### 2. Configure the Model

Open `docker-compose.yml` and set the `CLIP_MODEL` environment variable. For example:

```yaml
CLIP_MODEL: openai/clip-vit-base-patch16
```

You can choose any model from the [CLIP-compatible models](https://huggingface.co/models?search=clip) on Hugging Face.

### 3. Build and Run the Service

```shell
docker compose up -d --build
```

The service will be available at http://localhost:3000.

## API Reference

### /rank

Ranks text candidates against one or more image queries using cosine similarity and probability scores.

Request Format

* **queries**: A list of image inputs, either as img_uri or img_blob.
* **candidates**: A list of text descriptions.

Supported Image Formats

* **img_uri**: A direct image URL
* **img_blob**: A base64-encoded image string

```shell
curl -X 'POST' \
  'http://localhost:3000/rank' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "queries": [
    {
      "img_uri": "https://raw.githubusercontent.com/EvilFreelancer/docker-clip-api/refs/heads/main/assets/test_tshirt.jpg"
    }
  ],
  "candidates": [
    {"text": "t-shirt"},
    {"text": "jeans"},
    {"text": "jacket"},
    {"text": "dress"},
    {"text": "skirt"},
    {"text": "shorts"},
    {"text": "coat"},
    {"text": "shoes"},
    {"text": "hat"},
    {"text": "sweater"}
  ]
}'
```

Sample Response

```shell
{
  "probabilities": [
    [
      0.9982102324463897,
      0.00001807320921286219,
      ...
      0.000036178202084800335
    ]
  ],
  "cosine_similarities": [
    [
      0.29196685552597046,
      0.18277397751808167,
      ...
      0.1897142380475998
    ]
  ]
}
```

## License

MIT License. See [LICENSE](./LICENSE) for details.
