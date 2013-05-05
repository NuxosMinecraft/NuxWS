class AdminController < ApplicationController
  before_filter :at_least_modo
  # load_and_authorize_resource # unused here

  # GET /admin
  # GET /admin.json
  def index
    @cur_tab = :admin
    respond_to do |format|
      @jsonapi = {
        :getServer => JsonApi ? JsonApi.send('getServer') : nil
      }
      format.html # index.html.erb
      #format.json { render json: @logs }
    end
  end
end
