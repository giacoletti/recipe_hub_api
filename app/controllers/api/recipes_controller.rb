class Api::RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_404_error

  def index
    recipes = Recipe.by_recently_created.limit(30)
    render json: recipes, each_serializer: Recipe::IndexSerializer
  end

  def show
    render json: @recipe, serializer: Recipe::ShowSerializer
  end

  def update
    @recipe.update(recipe_params)
    render json: { message: 'Your recipe was updated.' }
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
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params[:recipe].permit(:name, :instructions)
  end

  def render_404_error
    render json: { message: 'Recipe not found' }, status: 404
  end

  
end
