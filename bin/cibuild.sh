#!/usr/bin/env bash

# Fail fast and be aware of exit codes
set -eo pipefail

# Setup Ruby
curl -s -o use-ruby https://repository-cloudbees.forge.cloudbees.com/distributions/ci-addons/ruby/use-ruby
RUBY_VERSION=$(cat .ruby-version) . ./use-ruby
gem install --conservative bundler
bundle install

# run rails server via puma
# https://github.com/puma/puma#rails
rails s puma
