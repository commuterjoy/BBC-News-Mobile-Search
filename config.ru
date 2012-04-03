
require 'rubygems'
require 'sinatra'
require 'maruku'

root = ::File.dirname(__FILE__)

require ::File.join( root, 'app', 'lib', 'news', 'search.rb' )
require ::File.join( root, 'app', 'controllers', 'mobile.rb' )

run Mobile
