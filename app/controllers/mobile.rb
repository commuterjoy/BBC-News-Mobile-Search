
class Mobile < Sinatra::Base

  set :views, File.dirname(__FILE__) + '/../views'
  set :public, File.dirname(__FILE__) + '/../public'

# ----------- before
  
  before do
  end
  
# ----------- after

  after do  
    headers['Cache-Control'] = 'public, max-age=60'
  end
  
# ----------- helpers

  helpers do
  end

# ----------- api

  # search 
  get '/news/search' do
    page = (params[:page]) ? params[:page] : 1
    @results = Search.new.fetch(params[:q].to_s, page.to_i)
    @term = params[:q]
    erb :search, :layout => false
  end
  
  # default
  get '/' do
    redirect '/news/search?q=cats'
  end

end
