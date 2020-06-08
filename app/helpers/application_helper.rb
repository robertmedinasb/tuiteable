# frozen_string_literal: true

module ApplicationHelper
  def sort_users
    @users = User.all - current_user.followings
    @users -= [current_user] unless @users.find(current_user.id).nil?
    @users.sample(5)
  end
end
