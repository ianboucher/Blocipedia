class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia customer - #{current_user.username}",
      amount: @amount
    }
  end

  def create
    #amount in cents
    @amount = 1500

    customer = Stripe::Customer.create(
      email:  current_user.email,
      card:   params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @amount,
      description:  "Blocipedia customer - #{current_user.username}",
      currency:     "usd"
    )

    current_user.role = 1

    flash[:notice] = "Thank you for your payment!"
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

  end
end
