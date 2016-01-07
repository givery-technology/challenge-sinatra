require 'sinatra'
require 'data_mapper'
require 'json'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/service.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, Text, :required => true
  property :password, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
end  

DataMapper.finalize.auto_upgrade!

before do
  headers "Content-Type" => "application/json; charset=utf8"
end

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

# get '/api/user/:id' do 
get '/api/user' do 
  @user = User.get params[:id]
  # erb :user
  { :result => 'Logged In !'}.to_json
end

not_found do
  status 404
  'not found'
end