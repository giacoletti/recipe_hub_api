class Api::IngredientsController < ApplicationController
  def index
    ingredients = Ingredient.all
    render json: ingredients, each_serializer: Ingredient::IndexSerializer
  end
end
