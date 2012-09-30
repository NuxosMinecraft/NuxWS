class Admin::PluginsController < ApplicationController
  before_filter :at_least_modo

  def index
    @cur_tab = :plugins
    @jsonapi = {
      :getPlugins => JsonApi.call_api('getPlugins')
    }
  end
end
