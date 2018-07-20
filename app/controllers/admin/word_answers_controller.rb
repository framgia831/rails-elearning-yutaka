class Admin::WordAnswersController < ApplicationController
  before_action :admin_user
  def new
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:word_id])
    4.times {@word.word_answers.build}
  end

  def create
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:word_id])
    @word.assign_attributes(word_params) 
    if @word.save 
      flash[:success] = "Create "
      redirect_to admin_category_word_word_answers_path(@category,@word)
    else
      render "new"
    end
  end

  def show
    @word = Word.find_by(params[:word_id])
    @word_answers = @word.word_answers.paginate(page: params[:page],per_page:15)
  end

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words.find(params[:word_id])
    @word_answers = @words.word_answers.paginate(page: params[:page],per_page:15)
    @word_answer = @word_answers.where(params[:id])

    # @words = Word.find_by(params[:word_id])
    # @word_answers = WordAnswer.paginate(page: params[:page],per_page:15)


    #word
    # @words = @category.words.paginate(page: params[:page],per_page:15)
    # @word = @words.find_by(params[:id])
  end

private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  def word_params
  params.require(:word).permit(word_answers_attributes: [:word_id,:content,:correct])
  end
end