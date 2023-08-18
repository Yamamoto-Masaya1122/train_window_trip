class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash.now[:error] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_back_or_to root_path, success: 'ログアウトしました'
  end

end
