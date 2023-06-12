require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) {FactoryBot.create(:task, name: 'aaa')}
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: '洗濯'
        fill_in 'task[detail]', with: 'シーツを洗う'
        select '2023', from: 'task_expired_at_1i'
        select '10月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        select '完了', from: 'task_status'
        click_on "登録"
        expect(page).to have_content '洗濯'
        expect(page).to have_content 'シーツを洗う'
        expect(page).to have_content '2023-10-01'
        expect(page).to have_content '完了'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      @task1 = FactoryBot.create(:task, name: 'bbb', expired_at: '002024-08-06')
      @task2 = FactoryBot.create(:task, name: 'ccc', expired_at: '002024-07-06')
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
        # expect(page.text).to match(/#{@task1.name}[\s\S]*#{task.name}/)
        task_lists = all('.task_name')
        expect(task_lists[0]).to have_content 'ccc'
        expect(task_lists[1]).to have_content 'bbb'
      end
    end
    context '終了期限でソートするをクリックした場合' do
      it '終了期限の１番遅いタスクが１番上に表示される' do
        click_on "終了期限でソートする"
        sleep(2)
        task_expired_lists = all('.task_expired')
        expect(task_expired_lists[0]).to have_content '2024-08-06'
        expect(task_expired_lists[1]).to have_content '2024-07-06'
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
  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "task", status:"完了")
      FactoryBot.create(:task, name: "sample", status:"完了")
      FactoryBot.create(:task, name: "task2", status:"着手前")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[keyword]', with: 'tas'
        click_on "検索"
        expect(page).to have_content 'task'
        expect(page).to have_content 'task2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: 'task_status'
        click_on "検索"
        sleep(2)
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'task2'
        expect(page).to have_content 'sample'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[keyword]', with: 'tas'
        select '完了', from: 'task_status'
        click_on "検索"
        sleep(2)
        task_status_lists = all('.task_status')
        expect(task_status_lists).to_not have_content '未着手'
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'task2'
      end
    end
  end
end