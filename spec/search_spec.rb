require 'app/lib/news/search.rb'

describe Search do

    it "should contain no results before a search" do
        search = Search.new
        search.results.should be nil
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
        search.page.should eq(4)
    end

    it "should return uri, title and text for each result" do
        search = Search.new
        search.fetch('cats')
        search.results.first.title.should_not be nil 
    end

    it "should return the number of the next page of search results" do
        search = Search.new
        search.fetch('cats')
        search.page.should eq(2)
    end

end


