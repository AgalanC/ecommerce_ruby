class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Beer.where(id: @cart.keys)
  end

  def add_item
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity

    redirect_to cart_path, notice: 'Product added to cart successfully.'
  end

  def remove_item
    product_id = params[:product_id]

    if session[:cart] && session[:cart][product_id]
      session[:cart].delete(product_id)
    end

    redirect_to cart_path, notice: 'Product removed from cart successfully.'
  end

  def update_item
    product_id = params[:product_id]
    new_quantity = params[:quantity].to_i

    if session[:cart] && session[:cart][product_id]
      if new_quantity > 0
        session[:cart][product_id] = new_quantity
      else
        session[:cart].delete(product_id)
      end
    end

    redirect_to cart_path, notice: 'Cart updated successfully.'
  end
end
