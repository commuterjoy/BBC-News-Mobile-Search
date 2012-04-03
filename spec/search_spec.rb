require 'app/lib/news/search.rb'
require 'spec_helper.rb'

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

    it "should return no results for an empty serach result set" do
        search = Search.new
        search.fetch('adsgasdgadsg')
        search.results.should have(0).things
        search.page.should eq(0)
    end

    it "should return uri, title, term, section and text for each result" do
        search = Search.new
        search.fetch('cats')
        search.results.first.title.should == "In pictures: Mogadishu's fish market"
        search.results.first.uri.should == 'news/in-pictures-17404466'
        search.results.first.text.should include "and children now play" 
        search.results.first.section.should == "In Pictures" 
        search.results.first.term.should eq('cats')
    end

    it "should return the number of the next page of search results" do
        search = Search.new
        search.fetch('cats')
        search.page.should eq(2)
    end

    it "should combine several searches in to a chronologically ordered list" do
        search = Search.new
        search.fetch('cats')
        search.fetch('mushrooms')
        search.results.should have(40).things

        # chronology check
        original = search.results.map do |result|
            Time.now - result.date
        end
        original.should eq original.sort
    end

    it "should combine several searches and remove any duplicate results" do
        search = Search.new
        search.fetch('cats')
        search.fetch('cats')
        search.results.should have(20).things
    end

    it "should gracefully handle errors from the BBC search API" do
        search = Search.new
        search.fetch('onions')
    end

    it "should highlight the searched term in the results text" do
        search = Search.new
        search.fetch('cats')
        search.results.first.text.should include "where <b>cats</b> and children" 
    end

    it "should highlight multiple searched term in the results text" do
        search = Search.new
        search.fetch('the')
        search.results.first.text include "called <b>the</b> most dangerous city in <b>the</b>"
    end

end

describe String do

    it "should ignore case when highlighting terms" do
        "the Cats the cats".highlight include "the <b>Cats</b> the <b>cats</b>"
    end

end


