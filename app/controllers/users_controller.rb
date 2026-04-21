class UsersController < ApplicationController
  before_action :set_user

  def show
    @devices = @user.devices
    if @user.admin?
      @request_items = Request.where(approver_id: current_user.id, status: :pending)
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
