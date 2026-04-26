require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'ユーザー登録' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスが空欄の場合は無効であること' do
      user = build(:user)
      user.email = ''
      expect(user).to be_invalid
    end

    it 'ユーザー名が空欄の場合は無効であること' do
      user = build(:user)
      user.name = ''
      expect(user).to be_invalid
    end

    it 'パスワードが空欄の場合は無効であること' do
      user = build(:user)
      user.password = ''
      expect(user).to be_invalid
    end

    it 'パスワードが確認用パスワードと異なる場合は無効であること' do
      user = build(:user)
      user.password_confirmation = 'password2'
      expect(user).to be_invalid
    end

    it 'パスワードが5文字以下の場合は無効であること' do
      user = build(:user)
      user.password = 'pass'
      user.password_confirmation = 'pass'
      expect(user).to be_invalid
    end


    it 'メールアドレスが重複した場合は無効であること' do
      create(:user, email: "example@example.com")
      user = build(:user, email: "example@example.com")
      expect(user).to be_invalid
    end
  end
end
