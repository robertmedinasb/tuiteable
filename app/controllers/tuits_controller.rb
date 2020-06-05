# frozen_string_literal: true

class TuitsController < ApplicationController
  def explorer
    @tuits = Tuit.all.order(created_at: :desc)
  end

  def index
    @tuits = Tuit.all
    render json: @tuits
  end

  def show
    @tuit = Tuit.find(params[:id])
    @comment = Comment.new if user_signed_in?
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

  def comment
    @tuit = Tuit.find(params[:id])
    @body = params[:body]
    if user_signed_in?
      begin
        @comment = Comment.create!(user: current_user, tuit: @tuit, body: @body)
      rescue StandardError
        flash[:alert] = "The body can't be blank, try again..."
      end
      redirect_to tuit_path(@tuit)
    end
  end

  def create_comment
    params.permit(:id, :commenter, :comment)
    @tuit = Tuit.find(params[:id])
    if @tuit.comments << Comment.create!(body: params[:comment], user_id: params[:commenter])
      redirect_to tuit_path(@tuit)
    else
      render json: { ok: false }
    end
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body, :user_id, :tuit_id, :created_at, :updated_at)
    @tuits = Tuit.all.order(created_at: :desc)
  end

  def create
    @ntuit = Tuit.new(tuit_params)
    @ntuit.set_user!(current_user)
    @ntuit.save
    if @ntuit.save
      redirect_to root_path
    else
      render ‘not save tweet’
    end
  end
end
