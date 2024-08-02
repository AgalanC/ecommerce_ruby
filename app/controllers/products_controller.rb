class ProductsController < ApplicationController
  # skip_before_action :authenticate_user!

  def index
    if params[:filter] == 'new'
      @products = Beer.new_beers.page(params[:page]).per(10)
    elsif params[:filter] == 'recently_updated'
      @products = Beer.recently_updated.page(params[:page]).per(10)
    else
      @products = Beer.page(params[:page]).per(10)
    end
  end

  def show
    @product = Beer.find(params[:id])
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.beers.page(params[:page]).per(10)
  end

  def search
    @products = Beer.all
    if params[:keyword].present?
      @products = @products.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    @products = @products.page(params[:page]).per(10)
    render :index
  end
end
