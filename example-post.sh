#!/usr/bin/env bash
curl -v -k 'https://test:test@backchat.apps.staging.digital.gov.au/submit/2be6dc79-7c88-43ca-87cf-7fbfb7bc142f' \
  -F "userid=1" \
  -F "filecomment=This is an image file" \
  -F "file=@./app/assets/images/noun_36122.png" \
