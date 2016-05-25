class RefundsController < ApplicationController

  def create

    # Retrieve the user's subscription from Stripe and cancel it
    @membership = current_user.membership
    subscription = Stripe::Subscription.retrieve(@membership.subscribe_id)
    subscription.delete

    # Use the most recent full invoice from Stripe to calculate the refund amount
    ref_no = current_user.invoices.last.ref_no
    invoice = Stripe::Invoice.retrieve(ref_no)

    invoice_period = invoice.lines.data.first.period
    time_unused = invoice_period.end - Time.now.to_i
    refund_amount = invoice.amount_due * (time_unused.to_f / (invoice_period.end - invoice_period.start))

    # Tell Stripe to issue the pro-rated refund
    Stripe::Refund.create(charge: invoice.charge, amount: refund_amount.to_i )

    # Update the users role and set their private Wikis to public
    current_user.standard!
    current_user.wikis.update_all(private: false)

    flash[:notice] = "Your subscription has been cancelled and a refund issued"
    redirect_to root_path

  end
end
