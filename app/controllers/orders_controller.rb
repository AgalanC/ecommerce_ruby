class OrdersController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in
  before_action :set_order, only: [:update_status]

  def index
    @orders = current_user.orders.includes(:order_items, :beers, :tax)
  end

  def update_status
    if @order.update(status_params)
      redirect_to @order, notice: 'Order status was successfully updated.'
    else
      render :edit, alert: 'Error updating order status.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def status_params
    params.require(:order).permit(:status)
  end
end
