# frozen_string_literal: true

include Devise::Controllers::Helpers

class Api::TuitsController < ApiController
  skip_before_action :authorized, only: :index
  def index
    p current_user
    @tuits = if params[:user_id].nil?
               Tuit.all
             else
               User.find(params[:user_id]).tuits
             end
    render json: @tuits, status: :ok
  end

  def create
    # render json: {ok: false}, status: 200
    @ntuit = Tuit.new(tuit_params)
    @ntuit.set_user!(current_user)
    @ntuit.save
    if @ntuit.save
      render json: @ntuit, status: :ok
    else
      render 'Tuit not saved'
    end
  end

  def show
    @tuit = if params[:user_id].nil?
              Tuit.find(params[:id])
            else
              User.find(params[:user_id]).tuits.find(params[:id])
              end
    render json: @tuit, status: :ok
  end

  def update; end

  def destroy
    @tuit = if Tuit.exists?(params[:id])
              Tuit.find(params[:id])
            else
              false
            end

    if @tuit
      @tuit.destroy
      render json: {}, status: :no_content
    else
      render json: { ok: false, message: "Tuit doesn't exist!" }
    end
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body, :user_id, :tuit_id, :created_at, :updated_at)
  end
end
