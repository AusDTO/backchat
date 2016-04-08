#!/usr/bin/env bash
curl -v 'http://test:test@localhost:3000/submit/2b6a0896-5b23-41da-add5-05caec30f3d5' \
  -F "userid=1" \
  -F "filecomment=This is an image file" \
  -F "file=@./app/assets/images/noun_36122.png" \
