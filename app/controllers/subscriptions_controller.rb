class SubscriptionsController < ApplicationController

  require 'stripe'

  def new

    @membership = Membership.new

    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium - #{current_user.username}",
    }

  end

  def create

    customer = if current_user.customer_id?
                 Stripe::Customer.retrieve(current_user.customer_id)
               else
                 Stripe::Customer.create(email: current_user.email)
               end

    # binding.pry

    subscription = customer.subscriptions.create(
      plan:   'premium',
      card:   params[:stripeToken]
    )
    # binding.pry

    current_user.premium!
    current_user.update(customer_id: customer.id)

    @membership = Membership.new(
      subscribe_id: subscription.id,
      active_until: Time.at(subscription.current_period_end).to_datetime,
      status:       subscription.status,
      user_id:      current_user.id,
      active:       true
    )

    if @membership.save!
      flash[:notice] = "Thank you for your payment. Enjoy Blocipedia Premium!"
      redirect_to root_path
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_subscription_path

  end
end