class SessionsController < ApplicationController
  def new; end

  def create
    email = params.dig(:session, :email)
    password = params.dig(:session, :password)
    @user = User.find_by(email:)
    if @user&.authenticate(password)
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless logged_in?

    log_out
    redirect_to root_path
  end
end
