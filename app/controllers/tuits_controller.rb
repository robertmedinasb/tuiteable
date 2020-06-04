# frozen_string_literal: true

class TuitsController < ApplicationController
  def index
    @tuits = Tuit.all
    render json: @tuits
  end

  def show
    @tuit = Tuit.find(params[:id])
  end
end
