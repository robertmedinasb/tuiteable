class Api::TuitsController < ApiController
  def index
    @tuits = if params[:user_id].nil?
               Tuit.all
             else
               User.find(params[:user_id]).tuits
             end
    render json: @tuits, status: :ok
  end

  def show
    @tuit = if params[:user_id].nil?
              Tuit.find(params[:id])
            else
              User.find(params[:user_id]).tuits.find(params[:id])
              end
    render json: @tuit, status: :ok
  end

  def update

  end

  def destroy

  end

end