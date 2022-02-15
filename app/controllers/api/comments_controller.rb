class Api::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_params_presence, only: [:create]
  before_action :find_recipe, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :render_404_error

  def create
    comment = current_user.comments.create(comment_params.merge(recipe: @recipe))
    if comment.persisted?
      render json: { comment: comment }, status: 201
    else
      render_error(comment.errors.full_messages.to_sentence, 422)
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def comment_params
    params[:comment].permit(:body)
  end

  def render_404_error
    render json: { message: 'Recipe not found' }, status: 404
  end

  def validate_params_presence
    render_error('Comment is missing', :unprocessable_entity) if params[:comment].nil?
  end
end
