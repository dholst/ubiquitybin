class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to username_url(:username => current_user.login)
    end
  end
  
  def stay
    render :action => 'index'
  end
end
