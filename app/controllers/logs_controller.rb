class LogsController < ApplicationController
  before_filter :at_least_modo
  load_and_authorize_resource

  # GET /logs
  # GET /logs.json
  def index
    @logs = @logs.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logs }
    end
  end

end
