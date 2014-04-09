class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def notify_followers(subject, target, type)
    follower_notifier = FollowerNotifier.new(current_user)
    follower_notifier.notify(subject, target, type)
  end
end
