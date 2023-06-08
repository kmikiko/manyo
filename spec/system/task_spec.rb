require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: 'aaaaaa'
        fill_in 'task[detail]', with: 'bbbbb'
        click_on "登録"
        expect(page).to have_content 'aaaaaa'
        expect(page).to have_content 'bbbbb'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'aaa')
        task2 = FactoryBot.create(:task, name: 'bbb')
        visit tasks_path
        expect(page).to have_content task.name
        expect(page).to have_content task2.name
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content task.name
        expect(page).to have_content task.detail
      end
    end
  end
end