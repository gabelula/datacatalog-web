class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :confirm]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if @user.openid_identifier.present?
        @user.confirm!
        @user.deliver_welcome_message!
        UserSession.create(@user)
        flash[:notice] = t(:success_you_have_been_signed_in)
        redirect_to edit_profile_path
      else
        @user.deliver_confirmation_instructions!
        flash[:notice] = t(:your_account_has_been_created)
        redirect_to signin_path
      end
    else
      render :action => :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = t(:profile_updated)
      redirect_to edit_profile_path
    else
      render :edit
    end
  end

  def confirm
    @user = User.find_using_perishable_token(params[:token], 1.month)
    if @user.nil? || @user.confirmed?
      flash[:notice] = t(:no_confirmation_needed) 
      redirect_to signin_path
    elsif @user.confirm!
      @user.deliver_welcome_message!
      UserSession.create(@user)
      flash[:notice] = t(:thanks_you_are_now_signed_in) 
      redirect_to edit_profile_path
    else
      flash[:error] = t(:could_not_confirm_email)
      redirect_to signup_path
    end
  end
end
