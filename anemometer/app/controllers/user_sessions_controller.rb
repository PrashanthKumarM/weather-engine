class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      flash[:success] = "Welcome back!"
      redirect_to root_path
    else
      render :new
    end
  end

  def oauth_login
    user = User.from_omniauth(env["omniauth.auth"])
    @user_session = UserSession.new(user)
    if @user_session.save
      flash[:success] = "Welcome back!"
      redirect_to root_path
    else
      flash[:error] = "Cannot login!!"
      render :new
    end
  end



  def destroy
    current_user_session.destroy
    flash[:success] = "Goodbye!"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end