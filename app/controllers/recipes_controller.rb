class RecipesController < ApplicationController
    before_action :authorized
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Recipe.all, status: :ok
  end

  def create
    recipe = Recipe.create!(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: session[:user_id])
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
