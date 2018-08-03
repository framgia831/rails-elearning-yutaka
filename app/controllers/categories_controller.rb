class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page],per_page:15)
    # @category = @categories.find_by(params[:category_id])
  end
end