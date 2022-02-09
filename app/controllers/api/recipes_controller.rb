class Api::RecipesController < ApplicationController
  def index
    recipes = Recipe.by_recently_created.limit(30)
    render json: recipes, each_serializer: Recipe::IndexSerializer
  end

  def show
    recipe = Recipe.find(params['id'])
    render json: recipe, serializer: Recipe::ShowSerializer
  rescue ActiveRecord::RecordNotFound => e
    render_error('Recipe not found', 404)
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    render json: { message: 'Your recipe was updated.' }
  end

  private

  def recipe_params
    params[:recipe].permit(:name, :instructions)
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end
end
