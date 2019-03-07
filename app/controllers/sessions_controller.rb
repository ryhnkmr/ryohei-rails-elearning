class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      login(user)
      flash[:success] = "Successfully logged in"
      redirect_to root_url
    else
      flash[:danger] = "Invalid Credentials"
      render "new"
    end
  end

  def destroy
    logout
    flash[:info] = "Successfully logged out!"
    redirect_to root_url
  end
end
