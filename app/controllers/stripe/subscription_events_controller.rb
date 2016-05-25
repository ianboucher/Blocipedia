class Stripe::SubscriptionEventsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  # This controller listens for subscription updates from Stripe and updates the
  # Membership records in the DB accordingly
  
  def create
    # Upon receipt of Stripe webhook callback, retrieve subrciption event data
    event = Stripe::Event.retrieve(params[:id])

    subscription_id = event.data.object.id

    # Update the status of the corresponding Membership instance
    membership              = Membership.find_by! subscribe_id: subscription_id
    membership.status       = event.data.object.status
    membership.active_until = Time.at(event.data.object.current_period_end).to_datetime
    membership.cancel_at_period_end = event.data.object.cancel_at_period_end

    # If membership expired, update its status, change user's role and make their Wikis public
    if Time.now > membership.active_until
      membership.active = false
      current_user.standard!
      current_user.wikis.update_all(private: false)
    else
      membership.active = true
    end
    membership.save!
  end
end
