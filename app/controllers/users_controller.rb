class UsersController < ApplicationController
  before_action :set_user
  before_action :check_guest, only: :update

  def show
    @devices = @user.devices
    # 自分の申請のみ抽出
    @my_requests = Request.where(user_id: current_user.id)

    # 自分が借りている機器のみ抽出
    @borrowing_requests = current_user.requests.joins(:device).where(status: :approved, devices: { status: :borrowed }).includes(:device)

    if @user.admin?
      # 未承認のみ抽出
      @pending_requests = Request.where(approver_id: current_user.id, status: :pending)

      # 承認済みのみ抽出
      @requests_history = Request.where(approver_id: current_user.id).where.not(status: :pending)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(set_params)
      redirect_to user_path(current_user), notice: "プロフィール情報を更新しました"
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

  def check_guest
    if @user.email == 'guest@example.com' || @user.email == 'admin_guest@example.com'
      redirect_to :authenticated_root , alert: "ゲストユーザーは編集できません"
    end
  end
end
