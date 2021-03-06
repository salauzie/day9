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
	property :post, Text
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
	erb :index, layout: :layout
end

get '/create' do
	erb :create, layout: :layout
end

get '/edit' do
	erb :edit, layout: :layout
end

get '/viewpost' do
	erb :viewpost, layout: :layout
end

post '/add_blog' do
	p params
	@blog = BlogPost.new
	@blog.title = params[:title]
	@blog.post = params[:post]
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
	redirect to '/'
	erb :edit
end

get '/delete' do
	@blogs = BlogPost.all
end

get '/editpost' do
	@blogs = BlogPost.all	
end

patch '/editpost/:id' do
	@blog = BlogPost.get params[:id]
	@blog.update title:params[:edittitle]
	@blog.update post:params[:editpost]
	erb :edit
end
