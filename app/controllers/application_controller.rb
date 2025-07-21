class ApplicationController < ActionController::Base
  before_action do
    if current_user&.email&.include?("@brandnewbox.com")
      Rack::MiniProfiler.authorize_request
    end
  end

  before_action :set_sentry_context

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    home_index_path
  end

  def after_sign_up_path_for(resource)
    home_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_or_scope)
  end

  private

  def set_sentry_context
    return unless current_user
    Sentry.set_user(id: current_user.id, email: current_user.email)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_bio, :profile_picture])
  end
end

