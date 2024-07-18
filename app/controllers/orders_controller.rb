class OrdersController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def index
    @orders = current_user.orders.includes(:order_items, :beers, :tax)
  end
end
