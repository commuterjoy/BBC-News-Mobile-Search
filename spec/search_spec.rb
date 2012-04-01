require 'app/lib/news/search.rb'

describe Search do

    it "should contain no results before a search" do
        search = Search.new
        search.results.should have(0).things
    end

    it "should return a list of results" do
        search = Search.new
        search.fetch('cats')
        search.results.should have(20).things
    end

    it "should return a list of results from a specific page" do
        search = Search.new
        search.fetch('cats', 3)
        search.results.should have(20).things
        search.page.should eq(4) # 4th page
    end

    it "should return uri, title, term and text for each result" do
        search = Search.new
        search.fetch('cats')
        search.results.first.title.should_not be nil 
        search.results.first.uri.should_not be nil 
        search.results.first.text.should_not be nil 
        search.results.first.term.should eq('cats')
    end

    it "should return the number of the next page of search results" do
        search = Search.new
        search.fetch('cats')
        search.page.should eq(2)
    end

    it "should splice several searches in to a chronologically ordered list" do
        search = Search.new
        search.fetch('cats')
        search.fetch('dogs')
        search.results.should have(40).things

        # chronology, cast each date to a number and check the orginal equals a sorted version
        original = search.results.map do |result|
            Time.now - result.date
        end
        original.should eq original.sort
    end

end


