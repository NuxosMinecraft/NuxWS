class PlacesController < ApplicationController
  load_and_authorize_resource
  require 'open-uri'

  # GET /places
  # GET /places.json
  def index
    @places = @places.page params[:page]

    @feed_link = places_url(:format => :atom)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
      format.atom { render :layout => false }
    end
  end

  # GET /places/xxx
  # GET /places/xxx.json
  def show
    @place_images = nil
    if @place
      if @place.galleries.random
        @place_images = @place.galleries.random.images.random(3)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @select_markers = return_markers

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/xxx/edit
  def edit
    @select_markers = return_markers
  end

  # POST /places
  # POST /places.json
  def create
    @place.user = current_user

    @select_markers = return_markers

    puts params[:map_marker]


    respond_to do |format|
      if @place.save
        Log.logit!(:places, :notice, "User created place " + @place.name, {:user_id => @current_user.id, :place_id => @place.id})
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/xxx
  # PUT /places/.json
  def update
    @place.user = current_user

    respond_to do |format|
      if @place.update_attributes(params[:place])
        Log.logit!(:places, :notice, "User updated place " + @place.name, {:user_id => @current_user.id, :place_id => @place.id})
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/xxx
  # DELETE /places/xxx.json
  def destroy
    Log.logit!(:places, :notice, "User deleted place " + @place.name, {:user_id => @current_user.id, :place_id => @place.id})
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_path }
      format.json { head :no_content }
    end
  end

  private
  def return_markers
    begin
      @markers = JSON.parse(open("http://map.nuxos-minecraft.fr/tiles/_markers_/marker_world.json").read)
    rescue OpenURI::HTTPError
      return {}
    end

    @select_markers = {}

    @markers["sets"].keys.each do |set|
      @select_markers[set.to_s] = []
    end

    @markers["sets"].keys.each do |set_name|
      @markers["sets"][set_name]["markers"].each do |name, set|
        value = "#{set["x"]}/#{set["y"]}/#{set["z"]}"
        @select_markers[set_name.to_s] << [set["label"], value]
      end
    end

    return @select_markers
  end
end
