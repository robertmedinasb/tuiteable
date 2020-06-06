# frozen_string_literal: true

class Api::LikesController < ApiController
  def index
    @likes = if params[:tuit_id].nil?
               Like.all
             else
               Tuit.find(params[:tuit_id]).likes
             end
    render json: @likes, status: :ok
  end

  def create
    tuit = Tuit.find(params[:tuit_id])
    @like = Like.find_by(tuit: tuit, user: current_user)
    if @like.nil?
      like = Like.create!(tuit: tuit, user: current_user)
      render json: like, status: :ok
    else
      render json: {
        message: 'The like already exists',
        like_id: @like.id,
        tuit_id: tuit.id,
        user_id: tuit.user.id
      }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render plain: e
  end

  def show
    tuit = Tuit.find(params[:tuit_id])
    @like = Like.find_by(tuit: tuit, user: current_user)
    render  json: @like, status: :ok
  rescue StandardError => e
    render plain: "Like #{params[:id]} not finded"
  end

  def destroy
    @tuit = Tuit.find(params[:tuit_id])
    @like = Like.find_by(tuit: @tuit, user: current_user)
    if @like.nil?
      render plain: "The like doesn't exist"
    else
      render json: {
        message: "Like #{@like.id} was destroyed!",
        data: @like
      }, status: :ok
      Like.destroy(@like.id)
    end
  end
end
