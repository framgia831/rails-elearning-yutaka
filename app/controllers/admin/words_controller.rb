class Admin::WordsController < ApplicationController
  before_action :admin_user
  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)

      if @word.save 
        flash[:success] = "Create Word"
        redirect_to admin_category_words_path(@category)
      else
        render "new"
    end
  end

  def edit
    @category = Category.find_by(params[:category_id])
    @word = Word.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @word = Word.find_by(params[:id])
      if @word.update_attributes(word_params)
        flash[:success] = "Updated uccessfully"
        redirect_to admin_category_words_path
    else
        render 'edit'
      end
  end

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page: params[:page],per_page:15)
    @word = @words.find_by(params[:id])
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:info] = "Deleted category successfully."
    redirect_to request.referrer || root_url
  end
private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  def word_params
  params.require(:word).permit(:category_id,:content)
  end
end