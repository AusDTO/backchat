# Backchat
Unified user feedback/contact system allowing simple HTML form POSTs to become quantifiable and actionable user feedback.

[![Build Status](https://semaphoreci.com/api/v1/projects/c82d0221-805d-48dc-8d91-039f2f37e9d7/720541/badge.svg)](https://semaphoreci.com/maxious/backchat)

## TODO
- [ ] Many-to-many outputs to forms
- [ ]  Store submission via POST
- [ ]  Generate and run OutputJobs
- [ ]  Have outputs, email, zendesk, Google sheet with api authorisation tokens and other configuration/templates
- [ ]  Create end-to-end experience
- [ ]  Have input fields with types including restrictions on uploaded files
- [ ]  Have thank-you/error url
- [ ]  Produce stats via API eg. number responses/average satisfaction per page and total
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