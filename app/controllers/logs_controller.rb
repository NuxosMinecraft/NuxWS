class LogsController < ApplicationController
  load_and_authorize_resource
  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logs }
    end
  end
  
end
