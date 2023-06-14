class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, 
      notice: "ユーザーを削除しました。"
    else
      redirect_to admin_users_path, alert: "管理者は最低1名必要です。"
    end
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, 
                                 :admin, :password, :password_confirmation, :admin)
  end

  def if_not_admin
    redirect_to tasks_path,flash: {danger: '管理者権限がありません' } unless current_user.admin?
  end
end
