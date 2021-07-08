require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録に関するテスト' do
    before do
      FactoryBot.create(:user)
    end
    context '「Create my account」ボタンを押した場合' do
      it 'ユーザの新規登録ができる' do
        visit new_user_path
        fill_in 'user_name', with: 'ユーザA'
        fill_in 'user_email', with: 'user-a@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'Create my account'
        expect(page).to have_content('ユーザA')
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content('ログイン')
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'session_email', with: 'user@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'Log in'
    end
    context '「Log in」ボタンを押した場合' do
      it 'ログインができる' do
        expect(page).to have_content('ログインに成功しました！')
      end
    end
    context '「マイページ」リンクを押した場合' do
      it '自分の詳細画面(マイページ)に飛べる' do
        click_link 'マイページ'
        expect(page).to have_content('一般ユーザ')
      end
    end
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:second_user)
        visit user_path(user.id)
        expect(page).to have_content('タスク一覧')
      end
    end
    context '「ログアウト」リンクを押した場合' do
      it 'タスク一覧画面に遷移する' do
        click_link 'ログアウト'
        expect(page).to have_content('ログアウトしました')
      end
    end
  end
  describe '管理画面のテストト' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:second_user)
      visit new_session_path
      fill_in 'session_email', with: 'admin@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'Log in'
    end
    context '管理ユーザが管理画面にアクセスした場合' do
      it 'アクセスできる' do
        visit admin_users_path
        expect(page).to have_content('管理者用ユーザ一覧')
      end
    end
    context '一般ユーザが管理画面にアクセスした場合' do
      it 'アクセスできない' do
        click_link 'ログアウト'
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content('管理者ではないのでアクセスできません')
      end
    end
    context '管理ユーザがユーザの新規登録をした場合' do
      it '登録できる' do
        visit new_admin_user_path
        fill_in 'user_name', with: 'ユーザA'
        fill_in 'user_email', with: 'user-a@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        find("#user_admin").find("option[value='あり']").select_option
        click_button '登録する'
        expect(page).to have_content('新規作成しました！')
      end
    end
    context '管理ユーザがユーザの詳細画面に飛ぼうとした場合' do
      it 'アクセスできる' do
        user = FactoryBot.create(:user, name: "一般ユーザB", email: "user-b@example.com")
        visit admin_user_path(user.id)
        expect(page).to have_content('一般ユーザBさんのタスク一覧')
      end
    end
    context '管理ユーザがユーザの編集画面で編集しようとした場合' do
      it '編集できる' do
        user = FactoryBot.create(:user, name: "一般ユーザB", email: "user-b@example.com")
        visit admin_user_path(user.id)
        expect(page).to have_content('一般ユーザBさんのタスク一覧')
      end
    end
    context '管理ユーザがユーザの編集画面で編集しようとした場合' do
      it '編集できる' do
        user = FactoryBot.create(:user, name: "一般ユーザB", email: "user-b@example.com")
        visit edit_admin_user_path(user.id)
        fill_in 'user_name', with: '一般ユーザB'
        fill_in 'user_email', with: 'user-b@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        find("#user_admin").find("option[value='あり']").select_option
        click_button '登録する'
        expect(page).to have_content('更新しました！')
      end
    end
    context '管理ユーザがユーザを削除しようとした場合' do
      it '削除できる' do
        user = FactoryBot.create(:user, name: "一般ユーザB", email: "user-b@example.com", password: "password", password_confirmation: "password", admin: "あり")
        visit admin_users_path
        user_list = all('#user_row td')
        user_list[7].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content('削除しました！')
      end
    end
  end
end
