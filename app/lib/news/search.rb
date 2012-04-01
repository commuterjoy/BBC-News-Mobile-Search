require 'nokogiri'
require 'open-uri'
require 'ostruct'

class Search
    
    attr_accessor :uri, :result, :page

    def initialize
      @uri = 'http://www.bbc.co.uk/search/news/?q=%s&page=1&text=on'
    end

    def fetch(term=nil)

        @uri = @uri % [URI.escape(term)]
        doc = Nokogiri::HTML(open(@uri))

        @result = doc.css('#news-content .linktrack-item').collect do |item|
            link = item.css('a.title').first
            text = item.css('.details p').first
            date = item.css('.details .newsDateTime').first

            result = OpenStruct.new
            result.uri = link[:href]
            result.title = link.content
            result.text = text.content
            result.date = Time.parse(date[:class].gsub!('newsDateTime', '').strip!)
            result
        end

        @page = /page=([0-9]+)/.match(doc.css('#next').first[:href]).captures.first

        @result
    end

    def results
        (@result) ? @result : nil
    end
end

