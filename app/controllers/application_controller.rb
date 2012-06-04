class ApplicationController < ActionController::Base
  include SentientController
  helper_method :current_user_session, :current_user
  protect_from_forgery
  
  def index
    @place = Place.random # display random place in homepage
    @places = Place.limit(5)
    @docs = []
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
