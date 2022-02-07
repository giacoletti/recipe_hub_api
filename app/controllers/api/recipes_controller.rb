class Api::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: recipes, each_serializer: Recipe::IndexSerializer
  end
end
