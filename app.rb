require "sinatra"
require "sinatra/reloader"
require_relative "spoonacular"

spoon = Spoonacular.new

get("/") do
  erb(:index)
end
