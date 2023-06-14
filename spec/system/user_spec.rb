require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規ユーザー作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'サザエ'
        fill_in 'user[email]', with: 'sazae@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_on "登録"
        expect(page).to have_content 'サザエのページ'
      end
    end
  
    context 'ユーザーログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to_not have_content 'タスク管理'
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザーがログインした場合' do
      it '作成したユーザーのマイページが表示される' do
        
      end
    end
  
    context '一般ユーザーが他のユーザーの詳細画面にアクセスしようとした場合' do
      it 'タスク一覧画面に遷移する' do
        
      end
    end

    context 'ログアウトした場合' do
      it 'タスク一覧が表示できなくなる' do
        
      end
    end
  end

  describe '管理画面の機能' do
    context '管理者として登録されている場合' do
      it '管理画面が表示される' do
        
      end
    end
  
    context '一般ユーザーとして登録されている場合' do
      it '管理画面が表示されない' do
        
      end
    end

    context '管理ユーザーがユーザー作成した場合' do
      it '作成したユーザーのログインができる' do
        
      end
    end

    context '管理ユーザーが他のユーザーの詳細画面にアクセスした場合' do
      it '詳細画面の表示ができる' do
        
      end
    end

    context '管理ユーザーが他のユーザーの編集画面にアクセスした場合' do
      it 'ユーザー情報の編集ができる' do
        
      end
    end

    context '管理ユーザーが他のユーザーの削除した場合' do
      it '削除されたユーザーはログインができなくなる' do
        
      end
    end
  end
end
