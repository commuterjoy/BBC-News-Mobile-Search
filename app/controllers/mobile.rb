
class Mobile < Sinatra::Base

  set :views, File.dirname(__FILE__) + '/../views'
  set :public, File.dirname(__FILE__) + '/../public'

# ----------- before
  
  before do

    # does the querystring indicate that we should remove the layout ?
    @nolayout = (request.query_string =~ /embed/) ? true : false
    
    # are we loading secondary content?
    @secondary = (request.query_string =~ /secondary/) ? true : false
    
    # force the layout off when the 'secondary' content is loaded
    @nolayout = (@secondary) ? false : @nolayout

  end
  
# ----------- after

  after do  
      
    # caching for Heroku (Varnish) - http://devcenter.heroku.com/articles/http-caching
    headers['Cache-Control'] = 'public, max-age=60'

  end
  
# ----------- helpers

  helpers do
      
    def agent
      env['HTTP_USER_AGENT']
    end

    # stores locales for frontpages - GB, US, PAC etc.
    def locale
      env['HTTP_BBC_NEWS_LOCALE'] || nil
    end

    # ----------- view helpers
    
    # open a file in the public folder and return it's contents. like a shit mod_include. # @todo replace with JAMMIT
    def expand(asset=nil) 
      data = ''
      open(File.dirname(__FILE__) + '/../public/' + asset) {|f| data = f.read }
      data
    end
    
    def image_to_thumb(url=nil)
      url.gsub!('http://news.bbcimg.co.uk/media/images/', 'http://www.bbc.co.uk/moirastatic/img/iphone/styhalf/')
    end

    def image_to_ipad(url=nil)
      url.gsub!('http://news.bbcimg.co.uk/media/images/', 'http://www.bbc.co.uk/moirastatic/img/ipad/styhalf/')
    end
      
  end

# ----------- api

  # search 
  get '/news/search' do
    page = (params[:page]) ? params[:page] : 1
    @search = News::Search::fetch(params[:q], page.to_s)
    @term = params[:q]
    if @search
       @title = @search['title'].inner_text
    end
    erb :search, :layout => @nolayout
  end
  
  # default
  get '/' do
    redirect '/news/search?q=cats'
  end

end



