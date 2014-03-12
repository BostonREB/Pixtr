class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    if cookies[:user_id]
      @current_user ||= User.find(cookies.signed[:user_id])   #|| stops once it returns a true value
    end
  end
  helper_method :current_user

  def signed_in?
    current_user
  end
  helper_method :signed_in?

end