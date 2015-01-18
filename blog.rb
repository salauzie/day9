require 'sinatra'
require 'data_mapper'
require 'dm-mysql-adapter'
require 'mysql'

DataMapper.setup(
	:default,
	'mysql://root@localhost/blog'
)

class BlogPost
	include DataMapper::Resource
	# what is resource?
	property :id, Serial
	property :title, String
	property :text, String
	property :author, String
	property :date, String
	property :time, String
	# not sure what property does? string and serial are type of input?
end

DataMapper.finalize.auto_upgrade!
# don't know what this does?

get '/' do
	@blogs = BlogPost.all
	# functions like BlogPost.new, @blogs can be called anything, .all is everything in the list
	erb :index
end

get '/create' do
	erb :create
end

get '/edit' do
	erb :edit
end

get '/viewpost' do
	erb :viewpost
end

post '/add_blog' do
	p params
	@blog = BlogPost.new
	@blog.title = params[:title]
	@blog.text = params[:text]
	@blog.author = params[:author]
	@blog.date = params[:date]
	@blog.time = params[:time]
	@blog.save
	# saves to data base
	redirect to '/'
end


get '/blog/:id' do
	@blog = BlogPost.get params[:id]
	erb :edit
end

delete '/delete/:id' do
	@blog = BlogPost.get params[:id]
	@blog.destroy
	erb :edit
	redirect to '/'
end

get '/delete' do
	@blogs = BlogPost.all
end

