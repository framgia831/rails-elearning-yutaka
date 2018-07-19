class Admin::WordsController < ApplicationController
  before_action :admin_user
  def new
    @word = Word.new
  end

  def show
    @words = Word.paginate(page: params[:page],per_page:15)
    @category = Category.find_by(params[:category_id])
  end

  def create
    @word = Word.new(word_params)
      if @word.save 
        flash[:success] = "Create Word"
        redirect_to admin_category_words_path
      else
        render "new"
    end
  end

  def edit
    @category = Category.find_by(params[:category_id])
    @word = Word.find(params[:id])
  end
  def show
    
  end
  def update
    @category = Category.find_by(params[:category_id])
    @word = Word.find_by(params[:id])
      if @word.update_attributes(word_params);
        flash[:success] = "Updated uccessfully"
        redirect_to admin_category_words_path
    else
        render 'edit'
      end
  end

  def index
    @words = Word.paginate(page: params[:page],per_page:15)
    @word = @words.find
    @category = Category.find(params[:category_id])
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