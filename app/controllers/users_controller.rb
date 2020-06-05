# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
      if params[:id].nil?
        @user = User.find(current_user.id)
        @tuits = @user.tuits
      else
        @user = User.find(params[:id])
        @tuits = @user.tuits
      end
    end
  end
end
