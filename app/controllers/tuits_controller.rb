# frozen_string_literal: true

class TuitsController < ApplicationController
  def explorer
    @tuits = Tuit.all
  end
end
