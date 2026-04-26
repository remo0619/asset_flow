class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.find_or_create_by(email: "guest@example.com") do |u|
      u.name = "ゲスト(一般)"
      u.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to :authenticated_root, notice: "ゲスト(一般)でログインしました"
  end

  def admin_guest_sign_in
    user = User.find_or_create_by(email: "admin_guest@example.com") do |u|
      u.name = "ゲスト(管理者)"
      u.password = SecureRandom.urlsafe_base64
      u.authority = :admin
    end
    sign_in user
    redirect_to :authenticated_root, notice: "ゲスト(管理者)でログインしました"
  end
end
