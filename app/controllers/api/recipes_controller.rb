class Api::RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_params_presence, only: [:create]
  before_action :find_recipe, only: %i[show update]
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
    recipe = current_user.recipes.create(recipe_params)
    if recipe.persisted?
      render json: { recipe: recipe, message: 'Your recipe has been created' }, status: 201
    else
      render_error(recipe.errors.full_messages.to_sentence, 422)
    end
  end

  private

  def validate_params_presence
    if params[:recipe].nil?
      render_error('Missing params', :unprocessable_entity)
    elsif params[:recipe][:name].nil?
      render_error('Your recipe must have a name', :unprocessable_entity)
    elsif params[:recipe][:instructions].nil?
      render_error('Your recipe must have instructions', :unprocessable_entity)
    end
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params[:recipe].permit(:name, :instructions)
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def render_404_error
    render json: { message: 'Recipe not found' }, status: 404
  end
end
