require 'nokogiri'
require 'open-uri'

module News

  module Search

    @proxy = (ENV['http_proxy']) || nil 
    
    def fetch(term=nil, page=1, sort=nil, range=nil)

      url = 'http://www.bbc.co.uk/search/news/?q=%s&page=%s&text=on' % [URI.escape(term), page]
      doc = Nokogiri::HTML(open(url, :proxy => @proxy))

      begin

          data = {
              'title' => doc.css('title'),
              'links' => doc.css('#news-content a.title').collect do |link|
                  "<a href=\"#{link['href'].gsub!(/http:\/\/www.bbc.co.uk\/news\//, '')}\">#{link.content}</a>"
                end,
              'datetime' => doc.css('#news-content .newsDateTime'),
              'thumb' => doc.css('#news-content .thumb img'),
              'about' => doc.css('#news-content .itemText p'),
              'next' => /page=([0-9]+)/.match(doc.css('#next')[0].get_attribute('href')),
              'previous' => /page=([0-9]+)/.match(doc.css('#previous')[0].get_attribute('href')),
              'related' => doc.css('.story-related a'),
              'term' => doc.css('#topicTitle').inner_html
          }
          
          return data

      rescue

          return false

      end

    end
    
    # interface
    module_function :fetch

  end

end
 
