class MessagesController < ApplicationController
  load_and_authorize_resource :topic
  load_and_authorize_resource :messages, :through => :topic

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])
    @messages = @topic.messages.order('created_at DESC').limit(5)

    @message.title = @topic.title

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/xxx/edit
  def edit
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])
    @messages = @topic.messages.order('created_at DESC').limit(5)

    @message.title = @topic.title if @message.title.blank?

  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])

    @message.topic = @topic
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Message was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/xxx
  # PUT /topics/.json
  def update
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])

    params[:topic_id] = @topic.id

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to [@forum, @topic], notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/xxx
  # DELETE /topics/xxx.json
  def destroy
    # don't really destroy
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])

    # mark as deleted with default reason
    @message.deleted = true
    @message.deletion_reason = "Message deleted"
    @message.deletion_by = current_user.id

    @message.save

    respond_to do |format|
      format.html { redirect_to forum_topic_path(@forum, @topic) }
      format.json { head :no_content }
    end
  end

end
