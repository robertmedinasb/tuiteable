# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tuits = @user.tuits
    @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
  end

  def liked
    @user = User.find(params[:id])
    @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
    @owner = current_user.id == @user.id if user_signed_in?
    respond_to do |format|
      format.js
    end
  end
end
