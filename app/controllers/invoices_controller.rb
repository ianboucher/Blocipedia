class InvoicesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create

    # Upon receipt of Stripe webhook callback, retrieve invoice event data
    event = Stripe::Event.retrieve(params[:id])

    # Get Membership instance that corresponds to the subscription on invoice
    membership = Membership.find_by(subscribe_id: event.data.object.subscription)

    ref_no    = event.data.object.id
    charge_id = event.data.object.charge
    amount    = event.data.object.total

    # Store key invoice data locally and associate with corresponding Membership
    membership.invoices.new(ref_no: ref_no, charge_id: charge_id, amount: amount)
    membership.save!
  end
end
