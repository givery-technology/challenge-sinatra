require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/service.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, Text, :required => true
  property :password, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
end  

DataMapper.finalize.auto_upgrade!

get '/' do 
  @users = User.all :order => :id.desc
  @title = 'All Users'
  erb :challenge
end

post '/' do
  u = User.new
  u.email = params[:email]
  u.password = params[:password]
  u.save
  redirect '/'
end

get '/api/user/:id' do 
  @user = User.get params[:id]
  erb :user
end

not_found do
  status 404
  'not found'
end