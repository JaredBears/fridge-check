require "sinatra"
require "sinatra/reloader"
require_relative "spoonacular"

spoon = Spoonacular.new

get("/") do
  redirect to("/ingredients")
end

get("/ingredients") do
  erb(:ingredients)
end

get("/ingredients/results/") do
  ingredients = params[:ingredients].gsub(", ", ",+")
  number = "10"
  ranking = params[:ranking]
  ignorePantry = "true"
  @results = spoon.search_by_ingredient(ingredients, {number: number, ranking: ranking, ignorePantry: ignorePantry})
  erb(:results)
end

get("/recipes/:id") do
  id = params[:id]
  includeNutrition = "false"
  @recipe = spoon.search_by_recipe(id, includeNutrition)
  erb(:recipe)
end
