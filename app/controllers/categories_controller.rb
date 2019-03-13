class CategoriesController < ApplicationController
  def index
    @cats = Category.paginate(page: params[:page], per_page: 6)
  end
end
