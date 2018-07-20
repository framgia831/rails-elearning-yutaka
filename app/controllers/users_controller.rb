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
    @relationship = current_user.active_relationships.build
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

    def following
      @user = User.find(params[:id])
      @users = @user.following
      @title = "following"
      render 'show_follow'
  end

    def followers
      @user = User.find(params[:id])
      @users = @user.followers
      @title = "followers"
      render 'show_follow'
  end
  
private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
end
