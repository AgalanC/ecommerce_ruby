class CheckoutsController < ApplicationController
  def new
    @user = User.new
    @cart = session[:cart] || {}
    @products = Beer.where(id: @cart.keys)
  end

  def create
    @user = User.find_or_initialize_by(email: params[:email])
    @user.name = params[:name]
    @user.address = params[:address]

    if @user.save
      @tax = Tax.find(params[:province])
      @order = @user.orders.create(tax: @tax)

      @cart = session[:cart] || {}
      @products = Beer.where(id: @cart.keys)

      @products.each do |product|
        quantity = @cart[product.id.to_s]
        @order.order_items.create(beer: product, quantity: quantity, price: product.price)
      end

      @order.total_price = @order.order_items.sum { |item| item.price * item.quantity }
      @order.total_tax = @order.total_price * (@tax.gst_rate + @tax.pst_rate + @tax.hst_rate + @tax.qst_rate)
      @order.final_price = @order.total_price + @order.total_tax
      @order.save

      session[:cart] = {}
      redirect_to confirmation_checkout_path(order_id: @order.id)
    else
      flash.now[:alert] = 'Error creating order. Please check the form and try again.'
      render :new
    end
  end

  def confirmation
    @order = Order.find(params[:order_id])
    @user = @order.user
  end

  private

  def user_params
    params.permit(:name, :email, :address)
  end
end
