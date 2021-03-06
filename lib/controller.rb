require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path('.', __dir__))
require 'gossip'
require 'comment'

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
    erb :show, locals: {gossip_obj: Gossip.find(params["url_index"]), url_index: params["url_index"], comments_array: Comment.get_by_id(params["url_index"])}
  end
  post '/gossips/:url_index/update' do
    erb :update, locals: {gossip_obj: Gossip.find(params["url_index"]), url_index: params["url_index"]}
  end
  post '/gossips/:url_index/update/redirect' do
    erb :update_done, locals: {url_index: params["url_index"], update_done: Gossip.update(params["url_index"], params["new_author"], params["new_content"])}
  end
  post '/gossips/:url_index/comment' do
    Comment.new(params["url_index"], params["comment_author"], params["comment_content"]).save
    erb :show, locals: {gossip_obj: Gossip.find(params["url_index"]), url_index: params["url_index"], comments_array: Comment.get_by_id(params["url_index"])}
  end
  run! if app_file==$0
end