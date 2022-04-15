class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = User.find(params[:id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    customer = User.find_by(id: params[:user_id])
    tea = Tea.find_by(id: params[:tea_id])
    subscription = Subscription.create!(subscription_params)

    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  def destroy
    subscription = Subscription.find(params[:id])
    tea_subscription = TeaSubscription.find_by(subscription_id: subscription.id)
    tea_subscription.destroy
    if subscription.destroy
      render status: :no_content
    end
  end

private
  def subscription_params
    params.permit( :title, :price, :status, :frequency, :user_id, :teas)
  end
end
