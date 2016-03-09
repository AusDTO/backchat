# Backchat
Unified user feedback/contact system allowing simple HTML form POSTs to become quantifiable and actionable user feedback.

[![Build Status](https://semaphoreci.com/api/v1/projects/c82d0221-805d-48dc-8d91-039f2f37e9d7/720541/badge.svg)](https://semaphoreci.com/maxious/backchat)

## TODO
- [ ]  Have input fields including uploaded files
- [ ]  Have thank-you/error url options so users can get back to the page they were on
- [ ]  Produce system metrics via https://github.com/prometheus/client_ruby ie. # feedback recieved, feedback output jobs success/fail, by outputtype?

## Lifecycle of a submission
Submission is received as HTTP POST form or JSON, user sent back to thankyou

Validated; does it match a form uuid, do the fields validate

Store submission in DB

Create output objects to track progress of submissions into other systems

Create output jobs to action outputs asynchronously including for objects with no jobs


## Installing on OSX Development
```
#install homebrew 
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#install rbenv
brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rbenv install 2.2.3

#missing openssl.h
brew install openssl
brew link openssl --force
#Can't find the 'libpq-fe.h header
brew install postgresql
initdb /usr/local/var/postgres
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
# logs etc. in /usr/local/var/postgres/
createdb backchat_development
createdb backchat_test
#install deps
bundle install
echo 'SECRET_KEY_BASE=`rake secret`' > .env
# setup db with seed data
bin/rake db:create
bin/rake db:setup

# rebuild db with seed data
# need to revoke app if using google login if DB is wiped
# https://security.google.com/settings/security/permissions
bin/rake db:drop
bin/rake db:create
bin/rake db:migrate
bin/rake db:seed
```

### Setting Up/Deploying to cloudfoundry
Thanks to http://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html
```
cf create-service aws-rds-postgres 9.4-bronze backchat-db
cf push
# https://docs.pivotal.io/pivotalcf/devguide/services/migrate-db.html
cf set-env backchat SECRET_KEY_BASE `rake secret`
cf set-env backchat GOOGLE_CLIENT_SECRET 'abc'
cf set-env backchat GOOGLE_CLIENT_ID '123'

rake assets:precompile
cf push
```