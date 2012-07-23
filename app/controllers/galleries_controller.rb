class GalleriesController < ApplicationController
  load_and_authorize_resource

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = @galleries.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/xxx
  # GET /galleries/xxx.json
  def show
    @images = @gallery.images.order('created_at ASC').page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/xxx/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/xxx
  # PUT /galleries/.json
  def update
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/xxx
  # DELETE /galleries/xxx.json
  def destroy
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to galleries_path }
      format.json { head :no_content }
    end
  end

end
