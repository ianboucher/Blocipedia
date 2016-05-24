class RefundsController < ApplicationController

  def create
    @membership = current_user.membership

    subscription = Stripe::Subscription.retrieve(@membership.subscribe_id)
    subscription.delete
    current_user.standard!
    current_user.wikis.update_all(private: false)

    flash[:notice] = "Your subscription has been cancelled"
    redirect_to root_path
  end
end
