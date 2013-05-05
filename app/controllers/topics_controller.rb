class TopicsController < ApplicationController
  load_and_authorize_resource :forum
  load_and_authorize_resource :topic, :through => :forum

  before_filter :at_least_modo, :only => [:pin, :unpin, :lock, :unlock]

  # GET /topics
  # GET /topics.json
  def index
    @forum = Forum.find(params[:forum_id])
    redirect_to @forum
  end

  # GET /topics/xxx
  # GET /topics/xxx.json
  def show
    @forum = Forum.find(params[:forum_id])
    @messages = @topic.messages.accessible_by(current_ability).page params[:page]
    @feed_link = forum_topic_url(@forum, @topic, :format => :atom)

    if current_user
      @topic.mark_as_read! :for => current_user
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
      format.atom { render :layout => false }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @forum = Forum.find(params[:forum_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/xxx/edit
  def edit
    @forum = Forum.find(params[:forum_id])
    #@topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @forum = Forum.find(params[:forum_id])

    @topic.forum = @forum
    @topic.user = current_user
    @topic.moderation = true if current_user.role <= Role.get_id(:guest)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/xxx
  # PUT /topics/.json
  def update
    @forum = Forum.find(params[:forum_id])

    params[:user_id] = current_user.id
    params[:forum_id] = @forum.id
    params[:moderation] = true if current_user.role <= Role.get_id(:guest)

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/xxx
  # DELETE /topics/xxx.json
  def destroy
    @forum = Forum.find(params[:forum_id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_url(@forum) }
      format.json { head :no_content }
    end
  end

  # Pin and Lock functions
  def pin
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @topic.pin!

    respond_to do |format|
      format.html { redirect_to forum_topic_url(@forum, @topic), notice: 'Topic was successfully pinned.' }
      format.json { head :no_content }
    end
  end
  def unpin
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @topic.unpin!

    respond_to do |format|
      format.html { redirect_to forum_topic_url(@forum, @topic), notice: 'Topic was successfully un-pin.' }
      format.json { head :no_content }
    end
  end
  def lock
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @topic.lock!

    respond_to do |format|
      format.html { redirect_to forum_topic_url(@forum, @topic),notice: 'Topic was successfully locked.' }
      format.json { head :no_content }
    end
  end
  def unlock
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @topic.unlock!

    respond_to do |format|
      format.html { redirect_to forum_topic_url(@forum, @topic), notice: 'Topic was successfully unlocked.' }
      format.json { head :no_content }
    end
  end

  def follow
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    relation = TopicNotification.where(:topic_id => @topic.id, :user_id => current_user.id)
    if relation.count == 0
      TopicNotification.create(:topic_id => @topic.id, :user_id => current_user.id)
    end
    return redirect_to forum_topic_url(@forum, @topic), notice: 'You are now following this topic.'
  end

  def unfollow
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    relation = TopicNotification.where(:topic_id => @topic.id, :user_id => current_user.id)
    relation.each do |rel|
      rel.destroy
    end
    redirect_to forum_topic_url(@forum, @topic), notice: 'You are not following this topic anymore.'
  end

end
