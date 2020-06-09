# frozen_string_literal: true

class HomeController < ApplicationController
  def home
    if user_signed_in?
      users = current_user.followings
      users_ids = users.map(&:id)
      user_ids = users_ids << current_user.id
      @tuits = Tuit.limit(40).order(created_at: :desc).select { |tuit| users_ids.include?(tuit.user_id) }
      @user = User.find(current_user.id)
      @ntuit = Tuit.new
      render 'tuits/home'
    else
      redirect_to root_path
    end
  end

  def index
    @tuits = Tuit.limit(40).order(created_at: :desc)
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
