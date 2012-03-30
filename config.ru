
require 'rubygems'
require 'sinatra'

# lib's
Dir.glob('app/lib/news/story/*.rb').each { |f| require f }
Dir.glob('app/lib/news/*.rb').each { |f| require f }
Dir.glob('app/lib/*.rb').each { |f| require f }

# app
Dir.glob('app/controllers/*.rb').each { |f| require f }

run Mobile