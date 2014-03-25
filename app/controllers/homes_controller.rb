class HomesController < ApplicationController
  before_action :goto_dashboard, if: :signed_in?

  def show
  end

  def goto_dashboard
      redirect_to dashboard_path
  end
end