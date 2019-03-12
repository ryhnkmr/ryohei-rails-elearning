class AdminController < ApplicationController
  before_action :require_admin

  private
  def require_admin
     unless current_user.admin?
      flash[:danger]  = "You don't have a permission"
      redirect_to root_url
     end
  end
end