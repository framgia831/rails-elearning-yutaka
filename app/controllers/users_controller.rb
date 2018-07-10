class UsersController < ApplicationController
# before_action :correct_user, only: [:edit,:update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save 
			flash[:success] = "Welcome to E-learning"
			log_in @user
			redirect_to @user
		else
			render "new"
		end
	end

	def index
		@users = User.paginate(page: params[:page],per_page:15)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
    	if @user.update_attributes(user_params);
      		flash[:success] = "Updated uccessfully"
    		redirect_to @user
		else
      		render 'edit'
    	end
	end
	
private
	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end
	
end
