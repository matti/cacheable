require 'sinatra'

if settings.development?
  require 'sinatra/reloader'
end

def handler
  cache_enabled = params[:cache_enabled] == "yes"
  refresh = params[:refresh]
  max_age = if params[:max_age]
    Integer(params[:max_age])
  else
    30
  end

  if cache_enabled
    cache_control :public, :must_revalidate, :max_age => max_age
  end

  erb :index, locals: {
    cache_enabled: cache_enabled,
    max_age: max_age,
    refresh: refresh
  }
end

get '/' do
  handler
end

get '/:cache_enabled/:max_age' do
  handler
end

get '/:cache_enabled/:max_age/:refresh' do
  handler
end


get '/health' do
  "ok"
end
