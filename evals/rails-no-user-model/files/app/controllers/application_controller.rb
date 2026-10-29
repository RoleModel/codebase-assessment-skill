class ApplicationController < ActionController::Base
  before_action :require_password

  private

  # Everyone on the team shares one password.
  def require_password
    redirect_to new_session_path unless session[:unlocked]
  end
end
