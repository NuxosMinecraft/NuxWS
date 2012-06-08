class SettingsController < ApplicationController
  
  
  def index
    @settings = Settings.all
  end
end
