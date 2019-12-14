class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "メールアドレスを認証しました"
      redirect_to user
    else
      flash[:danger] = "メールアドレスの認証に失敗しました"
      redirect_to root_url
    end
  end
end
