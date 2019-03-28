class StaticPagesController < ApplicationController
  def home
    if cookies[:remember_token]
      redirect_to dashboard_url
    end
  end

  def about
  end

    
end
