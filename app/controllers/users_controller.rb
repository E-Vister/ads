class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :new]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Email updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
end

private

def user_params
  params.require(:user).permit(:username, :email, :phone, :password,
                               :password_confirmation)
end

def signed_in_user
  unless signed_in?
    flash[:danger] = "You don't have access to this page. Please sign in."
    redirect_to signin_url
  end
end

def correct_user
  @user = User.find(params[:id])
  redirect_to(root_url) unless current_user?(@user)
end

def admin_user
  redirect_to(root_url) unless current_user.admin?
end
