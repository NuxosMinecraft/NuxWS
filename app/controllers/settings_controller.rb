class SettingsController < ApplicationController
  before_filter :only_admin
  
  def index
    @settings = Settings.all
  end
  
  def update
    params.each_pair do |setting, value|
      Settings[setting] = value if !["utf8", "_method", "commit", "authenticity_token"].include?(setting)
    end
    redirect_to settings_path, :notice => 'Settings updated' # Redirect to the settings index
  end
end
