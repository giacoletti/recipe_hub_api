class Api::RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_params_presence, only: [:create]
  before_action :find_recipe, only: %i[show update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_404_error

  def index
    recipes = if params.include?(:user)
                user = User.where email: params[:user]
                Recipe.where(user: user).by_recently_created.limit(30)
              else
                Recipe.by_recently_created.limit(30)
              end
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
    render_error('Recipe is missing', :unprocessable_entity) if params[:recipe].nil?
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params[:recipe].permit(:name, :instructions, ingredients_attributes: %i[ingredient_id unit amount])
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def render_404_error
    render json: { message: 'Recipe not found' }, status: 404
  end
end
