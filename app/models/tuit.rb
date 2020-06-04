# frozen_string_literal: true

class Tuit < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments
  has_many :likes
end
