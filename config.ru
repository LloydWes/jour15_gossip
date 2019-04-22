require 'bundler'
Bundler.require
require 'rack'
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

# set :public_folder, File.dirname(__FILE__) + '/css'
# set :public_folder, File.dirname(__FILE__) + '/header.html'

# p $:
require 'controller'

run ApplicationController