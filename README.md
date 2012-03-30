
About
-----

A News CPS v6 screen scraper to help with mobile prototyping.

Usage
-----

The app is a simple Sinatra proxy server between your browser and the BBC News website.

 # dependencies
 sudo gem install nokogiri sinatra rack ruby-readability json --http-proxy=http://www-cache.reith.bbc.co.uk:80

 # optional proxy
 export http_proxy=http://www-cache.reith.bbc.co.uk

 # run the app
 rackup -p 8003

 # test it
 curl -i http://localhost:8003/news/entertainment-arts-12321610

JRuby
=====

As an aside, I also can run this on jruby on OSX (but you probably need to install libxml separately)

 # install it
 jruby -S gem install nokogiri sinatra rack ruby-readability json --http-proxy=http://www-cache.reith.bbc.co.uk:80
 export LD_LIBRARY_PATH=/opt/local/lib

 # run the app
 jruby -S rackup

Deployment
----------

We are using Heroku as the hosting environment. Create an Heroku account, install the 'heroku' gem and follow the quick start notes.

 http://devcenter.heroku.com/articles/quickstart

Then,

 heroku create

 git add .
 git commit -m "fixed x, y, and z"
 git push heroku master

You'll then be allocated a host name and the app with be deployed, Eg.

 http://young-warrior-122.heroku.com/about

If you are behind reith you'll have to use the SOCKS proxy in ~/.ssh/config

 Host heroku.com
 ProxyCommand /usr/bin/nc -X 5 -x socks-gw.reith.bbc.co.uk:1085 %h %p

Notes
-----

- It works inside or outside reith by setting your http_proxy
 - Isn't screen scraping bad? No, Google built a search engine by screen-scraping, tools like Readability, Opera Mini are common.
 - I've included a scoped search for News
 - Doesn't cope with pages written before v6, but I've tried to filter them out
 - Image adaptation, http://localhost:8003/image/http://elections.edelman.co.uk/wp-content/uploads/2010/05/10405933.jpg?w=200&h=200&q=80

