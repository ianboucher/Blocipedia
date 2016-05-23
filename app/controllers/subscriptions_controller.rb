class SubscriptionsController < ApplicationController

  require 'stripe'

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium - #{current_user.username}",
      # amount: @amount
    }
  end

  def create
    #amount in cents
    # @amount = 1500

    customer = Stripe::Customer.create(
      email:  current_user.email,
      plan:   'premium',
      card:   params[:stripeToken]
    )

    current_user.update(role: :premium)
    current_user.update(customer_id: customer.id)

    flash[:notice] = "Thank you for your payment!"
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_subscription_path

  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    subscription_id = customer.subscriptions.first.id
    subscription = Stripe::Subscription.retrieve(subscription_id)
    subscription.delete
    current_user.update(role: :standard)

    flash[:notice] = "Your subscription has been cancelled"
    redirect_to root_path
  end

end
