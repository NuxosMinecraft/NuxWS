class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :only_admin
  protect_from_forgery
  include SentientController
  require 'open-uri'
  before_filter :minecraft_version
  before_filter :maintenance_mode

  def index
    begin
      @online_players = JSON.parse(open("http://map.nuxos-minecraft.fr/standalone/dynmap_world.json").read)
    rescue OpenURI::HTTPError
      @online_players = nil
    end
    @online_players = @online_players["players"] if @online_players
    if !@online_players
      @online_players = []
    end

    @place = Place.random # display random place in homepage
    @place_images = nil
    if @place
      if @place.galleries.random
        @place_images = @place.galleries.random.images.random(3)
      end
    end

    @places = Place.limit(5)
    @forum_news = Forum.find_by_id(Settings.news_forum_id)
    @news = @forum_news.topics.limit(5).order("created_at DESC") if @forum_news

    if @forum_news
      @feed_link = forum_url(@forum_news, :format => :atom)
    end
  end

  def pony
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  def at_least_modo
    if !@current_user
      return redirect_to root_url, :error => "Access denied!"
    end
    if @current_user.role < Role.get_id(:moderator)
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

  def maintenance_mode
    return if self.controller_name == "user_sessions"
    mode = true if (Settings.app_maintenance == "yes")
    mode = false if @current_user and @current_user.at_least_modo?

    # Are allowed for ALL : login & logout
    # Are allowed for MODO/ADMINS : all
    # All other things are blocked
    if mode
      flash[:error] = "Maintenance is on, please come back later."
      render :maintenance, :layout => nil
    end
    flash[:info] = "Maintenance mode on" if Settings.app_maintenance == "yes"
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

  def require_no_user
      if current_user
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
  end

  def minecraft_version
    if JsonApi
      api = JsonApi.call_api('getServer')
      version = (api ? api["version"] : nil)
      split = version.match(/^git-Bukkit-.*-b(\d+)\w+ \(MC:\s(.*)\)$/i)
      return ["", "No version", "No version"] if !split
    else
      api = nil
      split = ["", "API down", "API down"]
    end
    @minecraft_version = {
      :bukkit => split[1],
      :minecraft => split[2]
    }
  end

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
