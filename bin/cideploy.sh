#!/bin/bash

# Exit immediately if any commands return non-zero
set -e
# Output the commands we run
set -x

# This is a modified version of the Cloud Foundry Blue/Green deployment guide:
#
# https://docs.pivotal.io/pivotalcf/devguide/deploy-apps/blue-green.html
#
# To ensure a site can be served from backchat.cfapps.io when updates are being
# pushed, we run two instances of the application (blue and green). To update
# the site, we change the blue application, then change the green.

# Update the blue app
cf unmap-route backchat-blue cfapps.io -n backchat
cf push backchat-blue --no-hostname --no-manifest --no-route -i 1 -m 256M
cf map-route backchat-blue cfapps.io -n backchat

# Update the green app
cf unmap-route backchat-green cfapps.io -n backchat
cf push backchat-green --no-hostname --no-manifest --no-route -i 1 -m 256M
cf map-route backchat-green cfapps.io -n backchat
