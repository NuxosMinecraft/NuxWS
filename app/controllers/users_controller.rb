class UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = @users.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/xxx
  # GET /users/xxx.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/xxx/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/xxx
  # PUT /users/.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/xxx
  # DELETE /users/xxx.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  # Non-RESTFULL URLs here.
  def messages
    @user = User.find(params[:user_id])
    @messages = @user.messages.page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def topics
    @user = User.find(params[:user_id])
    @topics = @user.topics.page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end
