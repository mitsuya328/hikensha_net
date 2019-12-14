class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        #message  = "認証メールを開いてメールアドレスを確認してください。#{view_context.link_to '認証メールを再送信', '#'}".html_safe
        message  = "認証メールを開いてメールアドレスを確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'ユーザー名またはパスワードが違います'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
