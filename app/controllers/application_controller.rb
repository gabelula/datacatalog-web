class ApplicationController < ActionController::Base
  include SortableTable::App::Controllers::ApplicationController

  helper :all
  helper_method :current_user_session, :current_user
  before_filter :show_title, :mailer_set_url_options, :set_analytics, :set_avatar

  unless ["development", "test"].include?(Rails.env)
    rescue_from ActiveRecord::RecordNotFound,
      ActiveRecord::RecordInvalid,
      ActionController::RoutingError,
      ActionController::UnknownController,
      ActionController::UnknownAction,
      :with => :render_404
    rescue_from NoMethodError,
      ActiveRecord::StatementInvalid,
      ActionView::TemplateError,
      :with => :render_500
  end

  def render_404(e)
    render :template => 'main/not_found', :status => "404 Not Found"
  end

  def render_500(e)
    render :template => 'main/internal_error', :status => "500 Error"
  end

  protected

  def extract_id(href)
    %r{/(.*)/(.*)}.match(href)[2]
  end

  private

  def set_avatar
    gender = rand(2) == 1 ? "male" : "female"
    ActionView::Base.default_gravatar_image = "#{root_url}images/avatar_#{gender}_lg.png"
  end

  def set_analytics
    file = Rails.root.join("config/analytics.yml")

    @analytics_key ||= if file.file?
      analytics = YAML.load_file(file)
      analytics["key"]
    else
      ENV["ANALYTICS_KEY"]
    end
  end

  def show_title
    @show_title = true
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = t(:message_you_must_be_logged_in_to_take_that_action)
      redirect_to signin_url
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = t(:message_you_must_be_logged_in_to_take_that_action)
      redirect_to profile_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
