class Stripe::ChargesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create

    event = Stripe::Event.retrieve(params[:id])
    # binding.pry
    charge_id = event.data.object.id
    amount = event.data.object.amount
    binding.pry
    charge = Charge.new(transaction_id: charge_id, amount: amount)
  end
end
