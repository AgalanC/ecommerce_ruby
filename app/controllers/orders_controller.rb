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

  def payment_success
    stripe_session_id = params[:payment_intent]
    session = Stripe::Checkout::Session.retrieve(stripe_session_id)
    if session.payment_status == 'paid'
      @order = Order.find_by(stripe_payment_reference: stripe_session_id)
      if @order
        @order.update(status: 'paid')
        flash[:notice] = "Payment was successful. Thank you for your order!"
        render "orders/payment_success"
      else
        flash[:alert] = "Order not found."
        redirect_to root_path
      end
    else
      flash[:alert] = "Payment was not successful. Please try again."
      redirect_to root_path
    end
  end

  def payment_failure
    flash[:alert] = "Payment failed. Please try again."
    redirect_to new_checkout_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def status_params
    params.require(:order).permit(:status)
  end
end
