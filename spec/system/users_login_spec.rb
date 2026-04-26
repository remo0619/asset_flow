require 'rails_helper'

RSpec.describe "ログイン機能", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:user) { create(:user) }

  it "ログイン後、機器一覧画面に遷移すること" do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました"
    expect(page).to have_content "機器一覧"
    expect(page).to have_current_path "/"
  end

  it "ログイン後、ログアウトができること" do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    click_on "ログアウト"
    expect(page).to have_current_path "/"
    expect(page).to have_content "ログイン"
  end
end
