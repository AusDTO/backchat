# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'rack/ssl'
# required password
#use Rack::Auth::Basic, 'Protected Area' do |username, password|
#  (username == 'test' && password == 'test')
#end

if ENV['RACK_ENV'] == 'production'
  use Rack::SSL
end

# gzip compression
use Rack::Deflater

# metrics
require 'prometheus/client/rack/collector'
require 'prometheus/client/rack/exporter'

use Prometheus::Client::Rack::Collector
use Prometheus::Client::Rack::Exporter

# web application firewall
use Rack::Session::Pool
require 'rack/protection'
use Rack::Protection, :except => [:remote_token]

# run the rails
run Rails.application
