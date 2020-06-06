class Api::LikesController < ApiController
  def index
    @likes = if params[:tuit_id].nil?
               Like.all
             else
               Tuit.find(params[:tuit_id]).likes
             end
    render json: @likes, status: :ok
  end
end