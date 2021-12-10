class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "User successfully created"
      redirect_to @user
    else
      render 'new'
    end
  end
end

private

def user_params
  params.require(:user).permit(:username, :email, :phone, :password,
                               :password_confirmation)
end
