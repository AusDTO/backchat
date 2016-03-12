#!/usr/bin/env bash
curl -v 'http://test:test@localhost:3000/submit/a0dbfb0d-0a74-4d0c-96e4-e5af840cc4fb' \
--data 'site_or_page=This+specific+page&satisfaction=75&feeling=Very+Satisfied&feedback=.&referrer=https%3A%2F%2Fgov-au.cfapps.io%2F&fp=Mozilla%2F5.0+(Macintosh%3B+Intel+Mac+OS+X+10_11_3)+AppleWebKit%2F537.36+(KHTML%2C+like+Gecko)+Chrome%2F48.0.2564.116+Safari%2F537.36'
