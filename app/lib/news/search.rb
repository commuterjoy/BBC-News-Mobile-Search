require 'nokogiri'
require 'open-uri'
require 'ostruct'

class Search
    
    attr_accessor :uri, :result, :page, :term

    def initialize
      @uri = 'http://www.bbc.co.uk/search/news/?q=%s&page=%s&text=on'
      @result = []
    end

    def fetch(term=nil, page=1)
        @term = term
        begin
            uri = @uri % [URI.escape(@term), page]
            doc = Nokogiri::HTML(open(uri))
        rescue
            return unless doc
        end
        self.hydrate(doc)
    end

    def hydrate(doc)
        
        @page = (doc.css('#next').first) ? /page=([0-9]+)/.match(doc.css('#next').first[:href]).captures.first.to_i : 0

        return unless results?(doc)

        results = doc.css('#news-content .linktrack-item').collect do |item|
            link = item.css('a.title').first
            text = item.css('.details p').first
            date = item.css('.details .newsDateTime').first

            result = OpenStruct.new
            result.uri = link[:href].gsub!('http://www.bbc.co.uk/', '')
            result.title = link.content
            result.text = text.content
            result.date = Time.parse(date[:class].gsub!('newsDateTime', '').strip!)
            result.section = item.css('.details .newsSection').first.content.gsub!(/(\s+\/.+)/, '')
            result.term = @term
            result
        end

        @result = @result|results
        @result = @result.sort_by { |item| item.date }.reverse # chronologically sort
        @result = @result.uniq_by { |item| item.uri }

        @result
    end

    # determine if the returned search has any results
    def results?(doc)
        doc.css('#news-content .linktrack-item').first
    end

    def results
        (@result) ? @result : nil
    end

end

# http://stackoverflow.com/questions/109781/uniq-by-object-attribute-in-ruby
class Array
    def uniq_by(&blk)
        transforms = []
        self.select do |el|
            should_keep = !transforms.include?(t=blk[el])
         transforms << t
         should_keep
        end
    end 
end

