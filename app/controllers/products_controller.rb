class ProductsController < ApplicationController
  def index
    @products = Beer.all
  end

  def show
    @product = Beer.find(params[:id])
  end
end
