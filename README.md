# Backchat
Unified user feedback/contact system allowing simple HTML form POSTs to become quantifiable and actionable user feedback.

[![Circle CI](https://circleci.com/gh/AusDTO/backchat.svg?style=svg&circle-token=91fb19660cb112017456896100284d9d305492d0)](https://circleci.com/gh/AusDTO/backchat)

## TODO
- [ ]  Have defined input fields including uploaded files
- [ ]  Generated forms based on defined fields
- [ ]  Multiple file uploads?
- [ ]  Have validation and pretty names for fields

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
cf create-service DTO-staging-RDS-postgres 9.4-t2.micro-5G backchat-db
cf push
# https://docs.pivotal.io/pivotalcf/devguide/services/migrate-db.html
cf set-env backchat SECRET_KEY_BASE `rake secret`
cf set-env backchat GOOGLE_CLIENT_SECRET 'abc'
cf set-env backchat GOOGLE_CLIENT_ID '123'

cf push -c "bundle exec rake db:structure:ar_load QUE_MODE=off QUE_WORKERS=0" #first time setup
cf push
```
