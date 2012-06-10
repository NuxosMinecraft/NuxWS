class ImagesController < ApplicationController
  load_and_authorize_resource
  
  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    @gallery = Gallery.find(params[:gallery_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/xxx
  # GET /images/xxx.json
  def show
    @image = Image.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new
    @gallery = Gallery.find(params[:gallery_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /images/xxx/edit
  def edit
    @image = Image.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])
    @gallery = Gallery.find(params[:gallery_id])
    
    @image.gallery = @gallery
    
    respond_to do |format|
      if @image.save
        format.html { redirect_to @gallery, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/xxx
  # PUT /images/.json
  def update
    @image = Image.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])
    
    respond_to do |format|
      if @image.update_attributes(params[:gallery])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/xxx
  # DELETE /images/xxx.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    @gallery = Gallery.find(params[:gallery_id])

    respond_to do |format|
      format.html { redirect_to gallery_path(@gallery) }
      format.json { head :no_content }
    end
  end
  
end
