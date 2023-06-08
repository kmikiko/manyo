require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) {FactoryBot.create(:task, name: 'aaa')}
    # task2 = FactoryBot.create(:task, name: 'bbb')
    # task3 = FactoryBot.create(:task, name: 'ccc')
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: 'aaaaaa'
        fill_in 'task[detail]', with: 'bbb'
        click_on "登録"
        expect(page).to have_content 'aaaaaa'
        expect(page).to have_content 'bbb'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      task1 = FactoryBot.create(:task, name: 'bbb')
      task2 = FactoryBot.create(:task, name: 'ccc')
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'bbb'
        expect(page).to have_content 'ccc'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task1 = FactoryBot.create(:task, name: 'bbb')
        task2 = FactoryBot.create(:task, name: 'ccc')
        expect(page.text).to match(/#{task2.name}[\s\S]*#{task1.name}/)
        # task_lists = all('.task_row')
        # expect(task_lists[0]).to eq 'ccc'
        # expect(task_lists[1]).to eq 'bbb'
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