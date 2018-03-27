require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/posts/new' do
    erb :'new'
  end

  post '/posts' do

        @post = Post.new
        @post.name = params[:name]
        @post.content = params[:content]
        @post.save
        @all = Post.all

      redirect to('/posts')
  end

  get '/posts' do

    @all = Post.all
    erb :'index'
  end

  get "/posts/:id" do
    @post = Post.find_by(id: params[:id])
    erb :'show'
  end

  get "/posts/:id/edit" do
    @post = Post.find_by(id: params[:id])

    erb :'edit'
  end

  patch "/posts/:id" do
    binding.pry
    @post = Post.all
    if @post.includes(:name => params[:name], content: params[:content])
      @post.update(:name => params[:name], :content => params[:content])
    end
    redirect to ("/posts/#{@post.id}")
  end

  delete '/posts/:id/delete' do

    @post = Post.find_by_id(params[:id])
    @post.destroy
    erb :delete
  end

end
