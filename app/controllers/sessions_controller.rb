class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
    session_params[:username],
    session_params[:password]
    )
    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash[:errors] = ["invalid credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
