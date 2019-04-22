require 'bundler'
Bundler.require

# require 'sinatra/base'
# require_relative '../view/index'

$LOAD_PATH.unshift(File.expand_path('.', __dir__))
require 'gossip'
# require 'gossip'
# require 'view'

class ApplicationController < Sinatra::Base
  attr_accessor :last_gossip
  get '/' do 
    erb :index, locals: {gossips: Gossip.all}
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new' do
    Gossip.new(params["author"], params["content"]).save
    erb :submited_gossip, locals: {author: params["author"], content: params["content"]}
  end
  get '/gossips/:url_index' do
    erb :show, locals: {gossip_obj: Gossip.find(params["url_index"]), url_index: params["url_index"]}
  end

  run! if app_file==$0
end