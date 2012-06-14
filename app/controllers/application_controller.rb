class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :only_admin
  protect_from_forgery
  include SentientController
  require 'open-uri'
  
  def index    
    @online_players = JSON.parse(open("http://map.nuxos-minecraft.fr/standalone/dynmap_world.json").read)
    @online_players = @online_players["players"] if @online_players
    
    @place = Place.random # display random place in homepage
    @place_images = nil
    if @place
      if @place.galleries.random
        @place_images = @place.galleries.random.images.random(3)
      end
    end
    
    @places = Place.limit(5)
    @forum_news = Forum.find_by_id(Settings.news_forum_id)
    @news = @forum_news.topics.limit(5) if @forum_news
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end
  
  def at_least_modo
    if !@current_user
      return redirect_to root_url, :error => "Access denied!"
    end
    if @current_user.role.rid < 12
      return redirect_to root_url, :error => "Access denied!"
    end
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
