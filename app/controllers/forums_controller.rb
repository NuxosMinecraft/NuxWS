class ForumsController < ApplicationController
  load_and_authorize_resource

  # GET /forums
  # GET /forums.json
  def index
    @categories = ForumCategory.accessible_by(current_ability).order('position ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/xxx
  # GET /forums/xxx.json
  def show
    @topics = @forum.topics.accessible_by(current_ability).order('pin DESC', 'created_at DESC').page params[:page]
    @feed_link = forum_url(@forum, :format => :atom)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum }
      format.atom { render :layout => false }
    end
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/xxx/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render json: @forum, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/xxx
  # PUT /forums/.json
  def update
    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/xxx
  # DELETE /forums/xxx.json
  def destroy
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_path }
      format.json { head :no_content }
    end
  end

  def mark_all_read
    if current_user
      Topic.mark_as_read! :all, :for => current_user
    end
    redirect_to forums_path
  end

end
