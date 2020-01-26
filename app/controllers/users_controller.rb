class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user,   only: %i(edit update destroy)
  before_action :check_admin,     only: :index

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @experiments = @user.experiments.order(created_at: :desc).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      #flash[:info] = "認証メールを送信しました。メールアドレスを確認してください"
      redirect_to root_url, info: "認証メールを送信しました。メールアドレスを確認してください"
    else
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      #flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user, success: "ユーザー情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    #User.find(params[:id]).destroy
    @user.destroy
    if current_user.admin?
      redirect_to users_url, success: "ユーザーを削除しました。"
    else
      #flash[:success] = "退会が完了しました。ご利用ありがとうございました。"
      redirect_to root_url, success: "退会が完了しました。ご利用ありがとうございました。"
    end
  end

  private

    def user_params
      # params.require(:user).permit(:name, :email, :password,
      #                              :password_confirmation)
      params.require(:user).permit(User::REGISTRABLE_ATTRIBUTES)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        redirect_to(root_url)
      end
    end

    # 管理者かどうか確認
    def check_admin
      redirect_to(root_url) unless current_user.admin?
    end
end
