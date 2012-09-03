class AdminController < ApplicationController
  before_filter :at_least_modo
  # load_and_authorize_resource # unused here

  # GET /admin
  # GET /admin.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @logs }
    end
  end
end
