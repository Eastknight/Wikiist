class ChargesController < ApplicationController

  def create

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Wikiist Premium Account - #{current_user.email}",
      currency: 'usd'
    )
    if charge.save
      flash[:notice] = "Your payment is confirmed. Thank you for the business."
      redirect_to root_path
    end      

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

  def new
    return redirect_to new_user_session_path, notice: 'You need to sign in.' unless current_user
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Wikiist Premium Account - #{current_user.email}",
      amount: Amount.default
    }
  end
end

class Amount
  def self.default
    1_00
  end
end