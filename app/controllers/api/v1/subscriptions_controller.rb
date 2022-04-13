class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = User.find(params[:id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
  end

  def delete
  end
end
