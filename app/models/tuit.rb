# frozen_string_literal: true

class Tuit < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments
  has_many :likes
  def set_user!(user)
    self.user_id = user.id
    self.save!
  end
end
