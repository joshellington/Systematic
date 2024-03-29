require 'newrelic_rpm'
require 'open-uri'
require 'json'
require 'date'
require 'time'
require 'user-agent'
require 'pp'

require './app/models/mail'

enable :raise_errors, :sessions, :dump_errors, :logging
enable :show_exceptions  # if development?

def base_uri
  base_uri_raw = request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
  path = URI.parse(request.env["REQUEST_URI"]).path
  base_uri = "http://"+base_uri_raw.split(path)[0]
end

def curr_path
  base_uri_raw = request.env["HTTP_REFERER"]
end

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

module Sinatra::Partials
  
end