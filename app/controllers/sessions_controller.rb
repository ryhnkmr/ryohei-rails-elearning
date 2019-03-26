class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      login(user)
      flash[:success] = "Successfully logged in"
      redirect_to dashboard_url
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

  def facebook_login
    @user = User.from_omniauth(request.env["omniauth.auth"])
       
    result = @user.save(context: :facebook_login)

    if result
      login @user
      redirect_to @user
    else
      abort
      redirect_to auth_failure_url
    end
  end

  def auth_failure
    @user = User.new
    flash[:danger] = "You failed facebook login"
    render 'new'
  end
end
