class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_signin!
    if current_user.nil?
      flash[:alert] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
  helper_method :require_signin!

  private 
  
  def authorize_admin!
    require_signin!

    # unless current_user.admin?
    unless current_user.try(:admin?)
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
