class ForumCategoriesController < ApplicationController
  load_and_authorize_resource

  # GET /forum_categories
  # GET /forum_categories.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum_categories }
    end
  end

  # GET /forum_categories/new
  # GET /forum_categories/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forum_categories/xxx/edit
  def edit
  end

  # POST /forum_categories
  # POST /forum_categories.json
  def create
    respond_to do |format|
      if @forum_category.save
        format.html { redirect_to forum_categories_path, notice: 'Forum category was successfully created.' }
        format.json { render json: @forum_category, status: :created, location: @forum_category }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forum_categories/xxx
  # PUT /forum_categories/.json
  def update
    respond_to do |format|
      if @forum_category.update_attributes(params[:forum_category])
        format.html { redirect_to forum_categories_path, notice: 'Forum category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_categories/xxx
  # DELETE /forum_categories/xxx.json
  def destroy
    @forum_category.destroy

    respond_to do |format|
      format.html { redirect_to forum_categories_path }
      format.json { head :no_content }
    end
  end

end
