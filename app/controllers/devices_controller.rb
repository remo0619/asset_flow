class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  DEVICE_COUNT = 10

  def index
    @devices = Device.order(created_at: :desc).page(params[:page]).per(DEVICE_COUNT)
  end

  def show
    @my_request = @device.requests.find_by(user_id: current_user.id, status: :approved )
  end

  def new
    @device = Device.new
  end

  def create
    @device = current_user.devices.build(set_params)
    if @device.save
      redirect_to devices_path, notice: "機器を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @device.update(set_params)
      redirect_to device_path(@device), notice: "機器情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @device.destroy
      redirect_to devices_path, notice: "機器を削除しました"
    else
      redirect_to device_path(@device), alert: "この機器には申請履歴があるため削除できません。"
    end
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def set_params
    params.require(:device).permit(:device_type, :serial)
  end
end
