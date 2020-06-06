class ApiController < ActionController::API
  before_action :authorized
  helper_method :logged_in?

  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  def logged_in?
    !current_user.nil?
  end
  def authorized
    render json: { ok: false, message: 'You must be logged in!' } if !logged_in?
  end

  private

  def after_successful_token_authentication
    # Make the authentication token to be disposable - for example
    renew_authentication_token!
  end
end