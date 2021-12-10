class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:session][:phone])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if signed_in?
    redirect_to root_url
  end
end
