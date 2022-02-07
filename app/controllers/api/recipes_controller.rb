class Api::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: { recipes: recipes }
  end
end
