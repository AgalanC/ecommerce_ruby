class CheckoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
    @cart = session[:cart] || {}
    @products = Beer.where(id: @cart.keys)
  end

  def create
    if user_signed_in?
      @user = current_user
    else
      @user = User.find_or_initialize_by(email: params[:email])
      @user.name = params[:name]
      @user.address = params[:address]
      @user.password = SecureRandom.hex(8) # Set a random password for guest users
    end

    if @user.save
      @tax = Tax.find(params[:province])
      @order = @user.orders.create(tax: @tax, status: 'unpaid')

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

      stripe_session_url = create_stripe_session(@order)
      redirect_to stripe_session_url, allow_other_host: true
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

  def create_stripe_session(order)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: order.order_items.map do |item|
        {
          price_data: {
            currency: 'usd', # Replace with the appropriate currency if needed
            product_data: {
              name: item.beer.name,
              description: item.beer.description,
            },
            unit_amount: (item.price * 100).to_i, # Stripe expects the amount in cents
          },
          quantity: item.quantity,
        }
      end,
      mode: 'payment',
      success_url: payment_success_orders_url + "?payment_intent={CHECKOUT_SESSION_ID}",
      cancel_url: payment_failure_orders_url
    )
    order.stripe_payment_reference = session["id"]
    order.save
    session.url
  end

  def user_params
    params.permit(:name, :email, :address)
  end
end
