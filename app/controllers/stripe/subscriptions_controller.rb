class Stripe::SubscriptionsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create

    # Upon receipt of Stripe webhook callback, retrieve subription event data
    event = Stripe::Event.retrieve(params[:id])

    subscription_id = event.data.object.id

    # Update the status of the corresponding Membership instance
    membership = Membership.find_by! subscribe_id: subscription_id
    membership.status       = event.data.object.status
    membership.active_until = Time.at(event.data.object.current_period_end).to_datetime

    if (membership.status == 'canceled') || (membership.status == 'unpaid')
      membership.active = false
    elsif Time.now > membership.active_until
      membership.active = false
    else
      membership.active = true
    end

    membership.save!
  end
end
