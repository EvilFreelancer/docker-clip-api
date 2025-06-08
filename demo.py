from transformers import CLIPProcessor, CLIPModel
from PIL import Image

model = CLIPModel.from_pretrained("openai/clip-vit-base-patch16")
processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch16")

image = Image.open("assets/test_tshirt.jpg")
texts = ["t-shirt", "jeans", "jacket", "dress", "skirt", "shorts", "coat", "shoes", "hat", "sweater"]

inputs = processor(text=texts, images=image, return_tensors="pt", padding=True)
outputs = model(**inputs)
logits_per_image = outputs.logits_per_image
probs = logits_per_image.softmax(dim=1)

print(f"Predicted class: {texts[probs.argmax()]}")
