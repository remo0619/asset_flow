class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :show_pending, :show_history, :approve, :reject, :return, :edit, :update, :destroy]

  def index
  end

  # 申請一覧表示
  def show
  end

  # 未承認申請一覧表示
  def show_pending
  end

  # 承認履歴表示
  def show_history
  end

  def new
    @request = Request.new
    @device = Device.find(params[:device_id])
    @admins = User.admin.where.not(id: current_user.id)
  end

  def create
    @request = current_user.requests.build(set_params)
    if @request.save
      redirect_to devices_path, notice: "申請を登録しました"
    else
      @device = Device.find(params[:request][:device_id])
      @admins = User.admin
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    if @request.update(status: :approved, comment: params[:request][:comment])
      @request.device.update(status: :borrowed)
      redirect_to user_path(current_user), notice: "申請を承認しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def reject
    if @request.update(status: :rejected, comment: params[:request][:comment])
      redirect_to user_path(current_user), notice: "申請を否認しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def return
    if @request.update(status: :returned)
      @request.device.update(status: :available)
      redirect_to user_path(current_user), notice: "機器を返却しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def set_params
    params.require(:request).permit(:start_date, :end_date, :status, :user_id, :approver_id, :device_id, :comment)
  end
end
