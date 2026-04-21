class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :approve, :reject, :return, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @request = Request.new
    @device = Device.find(params[:device_id])
    @admins = User.admin
  end

  def create
    @request = current_user.requests.build(set_params)
    if @request.save
      redirect_to devices_path
    else
      @admins = User.admin
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    if @request.update(status: :approved, comment: params[:request][:comment])
      @request.device.update(status: :borrowed)
      redirect_to user_path(current_user), notice: "依頼を承認しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def reject
    if @request.update(status: :rejected, comment: params[:request][:comment])
      redirect_to user_path(current_user), notice: "依頼を承認しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def return
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
