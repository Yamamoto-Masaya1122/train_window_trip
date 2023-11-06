class PasswordResetsController < ApplicationController
  skip_before_action :require_login
	
	#パスワードリセット申請ページを表示する
  def new; end

	#ユーザーがパスワード再設定フォームに電子メールを入力し、送信したときにここに表示されます。
  def create
    @user = User.find_by_email(params[:email])

	#パスワードをリセットして、メールをユーザーに送信する。（メールにはランダムなトークンを含むURLが入ってる）
    @user.deliver_reset_password_instructions! if @user

	#メールが見つかったかどうかに関わらず、ユーザーにメールが送信がされたことを伝える。
	#これは、どのメールがシステム内に存在するかという情報を攻撃者に漏らさないためである
    redirect_to login_path, success: 'パスワードリセット手順を送信しました'
  end

	#パスワード再設定フォームです
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

	#このアクションはユーザがパスワード再設定フォームを送信したときに発生する
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

	#フォームで入力した値をレコードに代入することで更新している
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを変更しました'
    else
      render :edit
    end
  end
end
