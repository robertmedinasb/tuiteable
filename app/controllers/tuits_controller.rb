# frozen_string_literal: true

class TuitsController < ApplicationController
  def explorer
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
  def destroy
   @dltuit = Tuit.find(params[:id])
   @dltuit.destroy
   redirect_to root_path
  end

  private
    def tuit_params
      params.require(:tuit).permit(:body, :user_id)
    end
end
