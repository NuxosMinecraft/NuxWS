class ApplicationController < ActionController::Base
  include SentientController
  helper_method :current_user_session, :current_user, :only_admin
  protect_from_forgery
  
  def index
    @place = Place.random # display random place in homepage
    @places = Place.limit(5)
    @news = []
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end
  
  def only_admin
    if !@current_user
      return redirect_to root_url, :error => "Access denied!"
    end
    if !@current_user.admin?
      return redirect_to root_url, :error => "Access denied!"
    end
  end
      
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
end
