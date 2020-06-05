# frozen_string_literal: true

class TuitsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def explorer
    @tuits = Tuit.all.order(created_at: :desc)
  end

  def index
    @tuits = Tuit.all
    render json: @tuits
  end

  def show
    @tuit = Tuit.find(params[:id])
  end

  def like
    params.permit(:id)
    @tuit = Tuit.find(params[:id])
    @like = Like.find_by(tuit_id: @tuit.id, user_id: current_user.id)
    if @like.nil?
      @like = Like.create!(user: current_user, tuit: @tuit)
      @like.save
    else
      Like.destroy(@like.id)
    end
    respond_to do |format|
      format.js
    end
  end

  def create_comment
    params.permit(:id, :comment)
    @tuit = Tuit.find(params[:id])
    # @tuit << Comment.new
    if Comment.create!(body: params[:comment], user_id: current_user.id, tuit_id: @tuit.id)
      redirect_to tuit_path(@tuit)
    else
      render json: {ok: false}
    end
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body, :user_id, :tuit_id, :created_at, :updated_at)
  end
end
