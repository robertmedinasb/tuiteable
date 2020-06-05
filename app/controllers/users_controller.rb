# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
      if params[:id].nil?
        @user = User.find(current_user.id)
        @tuits = @user.tuits
        @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
      else
        @user = User.find(params[:id])
        @tuits = @user.tuits
        @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
      end
    end
  end

  def liked
    @user = User.find(params[:id])
    @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
    respond_to do |format|
      format.js
    end
  end
end
