module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end
	
	def log_out
 	session.delete(:user_id)
 	flash[:info] = "You successfully logged out"
 	end
 	
end
