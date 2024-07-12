class PagesController < ApplicationController
  def show
    @page = StaticPage.find_by(title: params[:id].capitalize)
  end
end
