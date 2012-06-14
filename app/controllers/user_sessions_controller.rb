class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      Log.logit!(:sessions, :notice, "User logged in", {:user_id => @user_session.user.id})
      redirect_to @user_session.user
    else
      render :action => :new
    end
  end

  def destroy
    Log.logit!(:sessions, :notice, "User logged out", {:user_id => current_user.id})
    current_user_session.destroy
    redirect_to root_url
  end
end
