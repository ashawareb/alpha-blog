class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in? #make theese methods available in our viwes

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #convert anything to boolean !!
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end
end