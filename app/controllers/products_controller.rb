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

  def search
    @products = Beer.all
    if params[:keyword].present?
      @products = @products.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    render :index
  end
end
