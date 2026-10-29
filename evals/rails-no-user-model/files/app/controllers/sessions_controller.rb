class SessionsController < ApplicationController
  skip_before_action :require_password

  def new; end

  def create
    if params[:password] == "widgets2026"
      session[:unlocked] = true
      redirect_to root_path
    else
      render :new
    end
  end
end
