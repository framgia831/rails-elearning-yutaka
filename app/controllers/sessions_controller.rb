class SessionsController < ApplicationController
	def new
	end
  
	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
	  		log_in user
	  		flash[:success] = "You successfully logged in ."
	  		redirect_to user
		else
	  		flash[:danger] = "User doesn't exist"
	  		render 'new'
		end
  	end

  	def destroy
		log_out
		#session.delete(:user_id)
		redirect_to root_url
  	end
end
