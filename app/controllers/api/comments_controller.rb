class Api::CommentsController < ApiController

  def index
    @comments = if params[:tuit_id].nil?
               Comment.all
             else
               Tuit.find(params[:tuit_id]).comments
             end
    render json: @comments, status: :ok
  end

  def show
    @comment = if params[:tuit_id].nil?
                 Comment.find(params[:id])
            else
              Tuit.find(params[:tuit_id]).comments.find(params[:id])
            end
    render json: @comment, status: :ok
  end

end
