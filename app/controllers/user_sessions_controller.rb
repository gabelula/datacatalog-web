class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  before_filter :activate_authlogic

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]

    if @user_session.save
      flash[:notice] = t(:text_you_have_been_signed_in)
      redirect_to session.delete(:return_to) || root_path
    else
      render :action => "new" and return
    end
  end

  def update
    create
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_to root_url
  end

end
