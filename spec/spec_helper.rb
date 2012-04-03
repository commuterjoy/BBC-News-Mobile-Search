require 'webmock/rspec'

RSpec.configure do |config|

    config.before(:each) {

       # load fixtures
       cats_1 = IO.read('spec/fixtures/cats-page-1')
       cats_3 = IO.read('spec/fixtures/cats-page-3')
       adsgasdgadsg = IO.read('spec/fixtures/adsgasdgadsg')
       mushrooms = IO.read('spec/fixtures/mushrooms')

       # mock responses
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=1&q=cats&text=on").to_return(:status => 200, :body => cats_1, :headers => {})
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=3&q=cats&text=on").to_return(:status => 200, :body => cats_3, :headers => {})
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=1&q=adsgasdgadsg&text=on").to_return(:status => 200, :body => adsgasdgadsg, :headers => {})
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=1&q=mushrooms&text=on").to_return(:status => 200, :body => mushrooms, :headers => {})
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=1&q=onions&text=on").to_return(:status => 500, :body => '', :headers => {})
       stub_request(:get, "http://www.bbc.co.uk/search/news/?page=1&q=the&text=on").to_return(:status => 200, :body => cats_1, :headers => {})

    }

end

