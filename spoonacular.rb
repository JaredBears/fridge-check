require "http"
require "json"

# API info

API_KEY = ENV.fetch("SPOONACULAR")
API_URL = "https://api.spoonacular.com/"

class Spoonacular

  def search_by_ingredient(ingredients, options)
    results = []
    url = "#{API_URL}recipes/findByIngredients?apiKey=#{API_KEY}&ingredients=#{ingredients}&number=#{options[:number]}&ranking=#{options[:ranking]}&ignorePantry=#{options[:ignorePantry]}"
    raw_response = HTTP.get(url)
    parsed_response = JSON.parse(raw_response)
    # pp "RESPONSE: #{parsed_response}"
    for response in parsed_response
      recipe = RecipeAbridged.new(response)
      results.push(recipe)
    end
    return results
  end

  def search_by_recipe(recipe, includeNutrition)
    url = "#{API_URL}recipes/#{recipe}/information?apiKey=#{API_KEY}&includeNutrition=#{includeNutrition}"
    raw_response = HTTP.get(url)
    parsed_response = JSON.parse(raw_response)
    # pp "RESPONSE: #{parsed_response}"
    recipe = RecipeFull.new(parsed_response)
    return recipe
  end

end

class RecipeAbridged
  attr_accessor :id
  attr_accessor :title
  attr_accessor :image
  attr_accessor :imageType
  attr_accessor :usedIngredientCount
  attr_accessor :missedIngredientCount
  attr_accessor :missedIngredients
  attr_accessor :usedIngredients
  attr_accessor :unusedIngredients
  attr_accessor :likes

  def initialize(response)
    @id = response["id"]
    @title = response["title"]
    @image = response["image"]
    @imageType = response["imageType"]
    @usedIngredientCount = response["usedIngredientCount"]
    @missedIngredientCount = response["missedIngredientCount"]
    @missedIngredients = []
    for missed_ingredient in response["missedIngredients"]
      ingredient = Ingredient.new(missed_ingredient)
      @missedIngredients.push(ingredient)
    end
    @usedIngredients = []
    for used_ingredient in response["usedIngredients"]
      ingredient = Ingredient.new(used_ingredient)
      @usedIngredients.push(ingredient)
    end
    @unusedIngredients = response["unusedIngredients"]
    @likes = response["likes"]
  end

  def to_s
    return "#{@title} (#{@id})"
  end
end

class RecipeFull
  attr_accessor :id
  attr_accessor :title
  attr_accessor :image
  attr_accessor :imageType
  attr_accessor :servings
  attr_accessor :readyInMinutes
  attr_accessor :license
  attr_accessor :sourceName
  attr_accessor :sourceUrl
  attr_accessor :spoonacularSourceUrl
  attr_accessor :healthScore
  attr_accessor :spoonacularScore
  attr_accessor :pricePerServing
  attr_accessor :analyzedInstructions
  attr_accessor :cheap
  attr_accessor :creditsText
  attr_accessor :cuisines
  attr_accessor :dairyFree
  attr_accessor :diets
  attr_accessor :gaps
  attr_accessor :glutenFree
  attr_accessor :instructions
  attr_accessor :ketogenic
  attr_accessor :lowFodmap
  attr_accessor :occasions
  attr_accessor :sustainable
  attr_accessor :vegan
  attr_accessor :vegetarian
  attr_accessor :veryHealthy
  attr_accessor :veryPopular
  attr_accessor :whole30
  attr_accessor :weightWatcherSmartPoints
  attr_accessor :dishTypes
  attr_accessor :extendedIngredients
  attr_accessor :summary
  attr_accessor :winePairing
  attr_accessor :winePairingText

  def initialize(response)
    @id = response["id"]
    @title = response["title"]
    @image = response["image"]
    @imageType = response["imageType"]
    @servings = response["servings"]
    @readyInMinutes = response["readyInMinutes"]
    @license = response["license"]
    @sourceName = response["sourceName"]
    @sourceUrl = response["sourceUrl"]
    @spoonacularSourceUrl = response["spoonacularSourceUrl"]
    @healthScore = response["healthScore"]
    @spoonacularScore = response["spoonacularScore"]
    @pricePerServing = response["pricePerServing"]
    @analyzedInstructions = response["analyzedInstructions"]
    @cheap = response["cheap"]
    @creditsText = response["creditsText"]
    @cuisines = response["cuisines"]
    @dairyFree = response["dairyFree"]
    @diets = response["diets"]
    @gaps = response["gaps"]
    @glutenFree = response["glutenFree"]
    @instructions = response["instructions"]
    @ketogenic = response["ketogenic"]
    @lowFodmap = response["lowFodmap"]
    @occasions = response["occasions"]
    @sustainable = response["sustainable"]
    @vegan = response["vegan"]
    @vegetarian = response["vegetarian"]
    @veryHealthy = response["veryHealthy"]
    @veryPopular = response["veryPopular"]
    @whole30 = response["whole30"]
    @weightWatcherSmartPoints = response["weightWatcherSmartPoints"]
    @dishTypes = response["dishTypes"]
    @extendedIngredients = []
    for extended_ingredient in response["extendedIngredients"]
      # pp extended_ingredient
      extended_ingredient["amount"] = extended_ingredient["measures"]["us"]["amount"]
      extended_ingredient["unit"] = extended_ingredient["measures"]["us"]["unit"]
      extended_ingredient["unitShort"] = extended_ingredient["measures"]["us"]["unitShort"]
      extended_ingredient["unitLong"] = extended_ingredient["measures"]["us"]["unitLong"]
      ingredient = Ingredient.new(extended_ingredient)
      @extendedIngredients.push(ingredient)
    end
    @summary = response["summary"]
    @winePairing = response["winePairing"]
    @winePairingText = response["winePairing"]["pairingText"]

  end

  def to_s
    return "#{@title} (#{@id})"
  end
end

class Ingredient
  attr_accessor :id
  attr_accessor :amount
  attr_accessor :unit
  attr_accessor :unitShort
  attr_accessor :unitLong
  attr_accessor :aisle
  attr_accessor :name
  attr_accessor :original
  attr_accessor :originalName
  attr_accessor :meta
  attr_accessor :image

  def initialize(response)
    @id = response["id"]
    @amount = response["amount"]
    @unit = response["unit"]
    @unitShort = response["unitShort"]
    @unitLong = response["unitLong"]
    @aisle = response["aisle"]
    @name = response["name"]
    @original = response["original"]
    @originalName = response["originalName"]
    @meta = response["meta"]
    @image = response["image"]
  end

  def to_s
    return "#{@name} (#{@id})"
  end

end

test = Spoonacular.new
# puts test.search_by_ingredient("apples,bacon", {number: 2, ranking: 1, ignorePantry: true})
#puts test.search_by_recipe(716429, true)
