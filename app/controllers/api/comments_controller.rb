class Api::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.comments.create(comment_params.merge(recipe: recipe))
    if comment.persisted?
      render json: { comment: comment }, status: 201
    else
      render_error(comment.errors.full_messages.to_sentence, 422)
    end
  end

  private

  def render_error(message, status)
    render json: { message: message }, status: status
  end

  def comment_params
    params[:comment].permit(:body)
  end
end
