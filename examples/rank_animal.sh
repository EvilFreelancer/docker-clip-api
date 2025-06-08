curl -X 'POST' \
  'http://localhost:3000/rank' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "queries": [
    {
      "img_uri": "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg"
    }
  ],
  "candidates": [
    {
      "text": "picture of a dog"
    },
    {
      "text": "picture of a cat"
    },
    {
      "text": "picture of a bird"
    },
    {
      "text": "picture of a car"
    },
    {
      "text": "picture of a plane"
    },
    {
      "text": "picture of a boat"
    }
  ]
}'
