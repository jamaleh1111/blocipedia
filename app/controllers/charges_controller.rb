class ChargesController < ApplicationController
  
  

  def create
    if current_user.stripe_id.nil?
      amount = @amount
      @amount = 10_00

      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken],
        plan: 'Blocipedia'
      )

      # charge = Stripe::Charge.create(
      #   customer: customer.id,
      #   amount: @amount,
      #   description: "BigMoney Membership - #{current_user.email}",
      #   currency: 'usd'
      # )

      current_user.update_attributes(
        role: "premium", 
        stripe_id: customer.id, 
        stripe_subscription: customer.subscriptions.first.id
      )

      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      redirect_to current_user
    else
      flash[:notice] = "You already have an account."
      redirect_to current_user
    end
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      plan: 'Blocipedia',
      amount: @amount
    }
  end 

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription).delete
    current_user.update_attributes(role: "standard", stripe_subscription: nil, stripe_id: nil)
    flash[:success] = "Your subscription has been cancelled."
    redirect_to root_path
  end
end

  