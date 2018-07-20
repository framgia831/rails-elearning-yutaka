class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  def new
    @category = Category.new
  end

  def create
     @category = Category.new(category_params)
      if @category.save 
      flash[:success] = "Create Category"
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find_by(params[:category_id])
    @words = @category.words.where(params[:word_id])
    

    # @word = @category.words.find_by(params[:word_id])
    # @word_answers = @word.word_answers.where(params[:word_answers])
  end

  def index
    @categories = Category.paginate(page: params[:page],per_page:15)
  end
  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
      if @category.update_attributes(category_params);
        flash[:success] = "Updated uccessfully"
        redirect_to admin_categories_path
    else
        render 'edit'
      end
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
    def category_params
    params.require(:category).permit(:title,:description)
    end
end
