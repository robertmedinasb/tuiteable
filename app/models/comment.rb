# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :tuit, counter_cache: true
  belongs_to :user, through: :tuits
end
