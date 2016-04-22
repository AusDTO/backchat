# Backchat
[![Circle CI](https://circleci.com/gh/AusDTO/backchat.svg?style=svg&circle-token=91fb19660cb112017456896100284d9d305492d0)](https://circleci.com/gh/AusDTO/backchat)

Backchat is a system for enabling contact or feedback forms to be submitted from other websites and then passed on via various services such as email, [Zendesk](https://www.zendesk.com/), and [Slack](https://slack.com/).

Backchat is in active development. However it is **alpha software** and not yet being used by the DTO on any production sites.

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

## Copyright & License

Copyright Digital Transformation Office. Licensed under the MIT license. See LICENSE file for more details.
