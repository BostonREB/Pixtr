class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Pixtr Stripe customer',
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
    else

    current_user.stripe_id = customer.id
    current_user.save

    flash[:notice] = 'You are now a premium user!'
    redirect_to dashboard_path
  end


end
