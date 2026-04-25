class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :update

  private

  def check_guest
    if @user.email == 'guest@example.com' || @user.email == 'admin_guest@example.com'
      redirect_to :authenticated_root , alert: "ゲストユーザーは編集できません"
    end
  end
end
