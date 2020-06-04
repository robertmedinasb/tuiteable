# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tuits = Tuit.all.order(created_at: :asc)
    render 'tuits/explorer'
  end
end
