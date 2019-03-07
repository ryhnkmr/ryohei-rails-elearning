class StaticPagesController < ApplicationController
  def home
    if logged_in?
      render "users/show"
    end
  end

  def about
  end
end
