require 'rubygems'
require 'sinatra'
require './config/init'

#
# Before any route is run
before do
  @path = request.env['SCRIPT_NAME']
end

helpers do
  def code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    locals = options[:locals] || {}
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << erb(:"#{template}", options.merge(:layout =>
        false, :locals => {template_array[-1].to_sym => member}.merge(locals)))
      end.join("\n")
    else
      erb(:"#{template}", options)
    end
  end
end

#
# Routes

match '/' do
  @request = request

  @useragent = Agent.new(@request.user_agent)

  @client = {
    :browser => @useragent,
    :ip => request.ip
  }

  @share = code 6

  erb :index
end

match '/:id/?' do
  @id = params[:id]

  @request = request

  @useragent = Agent.new(@request.user_agent)

  @client = {
    :browser => @useragent,
    :ip => request.ip
  }

  @share = @id

  erb :single
end

match '/:id/send/?' do
  @id = params[:id]
  port = ':'+request.port.to_s if request.port != 80
  url = request.url.sub('/send','')

  Mailer.send('hello@joshellington.com', @id, 'Here is your link: '+url)

  redirect '/'+@id+'/'
end