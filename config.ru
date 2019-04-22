require 'bundler'
Bundler.require
require 'rack'
$LOAD_PATH.unshift(File.expand_path('./../lib', __FILE__))

# p $:
require 'controller'

run ApplicationController