class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    # abort
    if user && user.authenticate(params[:session][:password])
      login(user)
      # abort
      params[:session][:remember_me] == '1' ?  remember(user) : forget(user)
      flash[:success] = "Successfully logged in"
      # abort
      redirect_to dashboard_url
    else
      flash[:danger] = "Invalid Credentials"
      render "new"
    end
  end

  def destroy
    if logged_in?
      logout 
      flash[:info] = "Successfully logged out!"
      redirect_to root_url
    end
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
