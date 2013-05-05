class Admin::WorldsController < ApplicationController
  before_filter :at_least_modo

  def index
    @cur_tab = :worlds
    @jsonapi = {
      :getWorlds => JsonApi ? JsonApi.send('getWorlds') : []
    }
  end
end
