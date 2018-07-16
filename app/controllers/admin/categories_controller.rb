class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  def new
    @category = Category.new
  end

  def create
     @category = Category.new(title_params)
      if @category.save 
      flash[:success] = "Create Category"
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def show
    @category = Catrgory.new
  end

  def index
    @categories = Category.paginate(page: params[:page],per_page:15)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:info] = "Deleted category successfully."
    redirect_to request.referrer || root_url
  end
  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    def title_params
    params.require(:category).permit(:title,:description)
    end
end
