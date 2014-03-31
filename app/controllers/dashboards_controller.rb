class DashboardsController < ApplicationController

  def show
    @activities = current_user.activities.includes(:subject, :actor, :target)
  end
end
