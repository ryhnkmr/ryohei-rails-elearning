class Admin::UsersController < AdminController

  def index 
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def update
    user = User.find(params[:id])
    user.admin = 1
    user.save

    redirect_to admin_users_url
  end

  def destroy
    user = User.find(params[:id])
    user.admin = 0
    user.save

    redirect_to admin_users_url
  end

end
