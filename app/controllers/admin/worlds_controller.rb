class Admin::WorldsController < ApplicationController
  before_filter :at_least_modo

  def index
    @cur_tab = :worlds
    @jsonapi = {
      :getWorlds => JsonApi.call_api('getWorlds')
    }
    require "pp"
    pp @jsonapi
  end
end
