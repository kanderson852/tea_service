class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = User.find(params[:id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    # require "pry"; binding.pry
    customer = User.find(params[:subscription][:user_id])
    subscription = customer.subscriptions.create(title: params[:subscription][:title], price: params[:subscription][:price], frequency: params[:subscription][:frequency], teas: params[:subscription][:teas])
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    end
  end

  def destroy
    subscription = Subscription.find(params[:id])
    tea_subscription = TeaSubscription.find_by(subscription_id: subscription.id)
    tea_subscription.destroy
    if subscription.destroy
      render status: :no_content
    end
  end

  # private
  #   def subscription_params
  #     params.require(:subscription).permit(:title, :price, :status, :frequency, :teas, :user_id)
  #   end
end
