# frozen_string_literal: true

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

  def create
    tuit = params[:comment]
    body = tuit[:body]
    if body.nil?
      render plain: "You have to put a comment:{ body:'Your body here'}"
    else
      @tuit = Tuit.find(params[:tuit_id])
      @comment = Comment.create!(body: body, tuit: @tuit, user: current_user)
      render json: @comment, status: :ok
    end
  end

  def destroy
    @tuit = Tuit.find(params[:tuit_id])
    @comments = @tuit.comments
    if @comments.empty?
      render plain: "This tuit doesn't have any comment"
    else
      begin
        @comment = @comeximents.find(params[:id])
        render json: {
          messages: 'The comment was succesfully deleted',
          data: @comment
        }, status: :ok
        @comment.destroy
      rescue StandardError => e
        render plain: "This comment doesn't have any comments"
      end
    end
    # @owner = Tuit.find(params[:id]).user
    # unless @owner == current_user
    #   return render plain: 'You should be the owner to do this action :('
    # end

    # @comment_ destroyed = Comment.destroy()
    # render json: params
  end
end
