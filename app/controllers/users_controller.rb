class UsersController < ApplicationController
  before_action :set_user

  def show
    @devices = @user.devices
    if @user.admin?
      # 未承認のみ抽出
      @pending_requests = Request.where(approver_id: current_user.id, status: :pending)

      # 承認済みのみ抽出
      @requests_history = Request.where(approver_id: current_user.id).where.not(status: :pending)

      # 自分の申請のみ抽出
      @my_requests = Request.where(user_id: current_user.id)
    else
      # 自分の申請のみ抽出
      @my_requests = Request.where(user_id: current_user.id)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(set_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_params
    params.require(:user).permit(:name, :email)
  end
end
