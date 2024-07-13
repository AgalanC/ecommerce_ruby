class ProductsController < ApplicationController
  def index
    @products = Beer.all
  end

  def show
    @product = Beer.find(params[:id])
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.beers
  end
end
