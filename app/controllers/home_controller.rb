# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tuits = Tuit.limit(40).order(created_at: :desc)
    @users = User.all.sample(5)
    unless @users.find(current_user).nil?
      @users -= [current_user]
    end
    if user_signed_in?
      @user = User.find(current_user.id)
      @ntuit = Tuit.new
    end
    render 'tuits/explorer'
  end

  def signup
    flash[:notice] = 'You must be registered to continue '
    render 'tuits/explorer'
  end
end
