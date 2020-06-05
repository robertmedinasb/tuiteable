# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tuits = Tuit.all.order(created_at: :asc)
    @user = User.find(current_user.id) 
    @ntuit = Tuit.new
    render 'tuits/explorer'
  end
end 
