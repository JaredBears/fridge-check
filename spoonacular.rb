require "http"
require "json"

# API info

API_KEY = ENV.fetch("SPOONACULAR")
API_URL = "https://api.spoonacular.com/"

class Spoonacular

  def search_by_ingredient(ingredients, options)
    url = "#{API_URL}recipes/findByIngredients?apiKey=#{API_KEY}&ingredients=#{ingredients}&number=#{options[:number]}&ranking=#{options[:ranking]}&ignorePantry=#{options[:ignorePantry]}"
    raw_response = HTTP.get(url)
    parsed_response = JSON.parse(raw_response)
    return parsed_response
  end

end

#test = Spoonacular.new
#puts test.search_by_ingredient("apples", {number: 2, ranking: 1, ignorePantry: true})
