class ImagesController < ApplicationController
  load_and_authorize_resource

  # GET /images
  # GET /images.json
  def index
    @gallery = Gallery.find(params[:gallery_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/xxx
  # GET /images/xxx.json
  def show
    #@gallery = Gallery.find(params[:gallery_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

end
