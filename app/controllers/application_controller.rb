class ApplicationController < ActionController::Base
  before_action do
    if current_user&.email&.include?("@brandnewbox.com")
      Rack::MiniProfiler.authorize_request
    end
  end

  before_action :set_sentry_context

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_sentry_context
    return unless current_user
    Sentry.set_user(id: current_user.id, email: current_user.email)
  end
end
