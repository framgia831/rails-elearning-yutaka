class Admin::WordAnswersController < ApplicationController
	before_action :admin_user
	def new
    @category = Category.find_by(params[:category_id])
		@word = Word.find(params[:word_id])
		4.times{@word.word_answers.build}
	end

	def create
		@word = Word.find(params[:word_id])
		@word.assign_attributes(word_params)
		if @word.save 
      flash[:success] = "Create "
      redirect_to admin_category_word_word_answers_path
    else
      render "new"
    end
	end

  def index
  	@word_answers = WordAnswer.paginate(page: params[:page],per_page:15)
    @words = Word.find_by(params[:word_id])
    @category = Category.find_by(params[:category_id])
  end

private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  def word_params
  params.require(:word).permit(word_answers_attributes: [:word_id,:content,:correct])
  end
end