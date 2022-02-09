class Api::RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

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

  def create
    recipe = Recipe.create(recipe_params)
    recipe.user = User.find_by email: params['recipe']['user']
    if recipe.persisted?
      render json: { recipe: recipe, message: 'Your recipe is created for you!' }, status: 201
    else
      render_error(recipe.errors.full_messages.to_sentence, 422)
    end
  end

  private

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def recipe_params
    params[:recipe].permit(:name, :instructions)
  end
end
