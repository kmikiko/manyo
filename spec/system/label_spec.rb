require 'rails_helper'
RSpec.describe 'ラベル付け機能', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, :with_label, user: user, name: 'task_a')}
  before do
    visit new_session_path
    fill_in "session[email]",with: user.email
    fill_in "session[password]",with: user.password
    click_on "ログイン"
  end
  describe 'ラベル付け機能' do
    context '新規作成画面でラベルを作成した場合' do
      it '一覧画面でつけたラベルが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: '洗濯'
        fill_in 'task[detail]', with: 'シーツを洗う'
        select '2023', from: 'task_expired_at_1i'
        select '10月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        select '完了', from: 'task_status'
        check '家事'
        click_on "登録"
        sleep 2
        task_label_lists = all('.task_label')
        expect(task_label_lists.first).to have_content '家事'
        expect(task_label_lists.first).to_not have_content '仕事'
      end
    end
    context '新規作成画面でラベルを複数つけた場合' do
      it 'すべてのラベルが一覧画面に反映される' do
        visit new_task_path
        fill_in 'task[name]', with: '出張'
        fill_in 'task[detail]', with: '大阪へ行く'
        select '2023', from: 'task_expired_at_1i'
        select '11月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        select '未着手', from: 'task_status'
        check '仕事'
        check '趣味'
        click_on "登録"
        sleep 2
        task_label_lists = all('.task_label')
        expect(task_label_lists.first).to have_content '仕事'
        expect(task_label_lists.first).to have_content '趣味'
        expect(task_label_lists.first).to_not have_content '家事'
      end
    end
  end

  describe '編集機能' do  
    context '編集画面でラベルを編集した場合' do
      it '一覧画面に変更内容が反映される' do
        visit tasks_path
        page.accept_confirm do
          click_on '編集'
        end
        uncheck '仕事'
        uncheck '趣味'
        click_on "登録"
        task_label_lists = all('.task_label')
        expect(task_label_lists.first).to_not have_content '仕事'
        expect(task_label_lists.first).to_not have_content '趣味'
        expect(task_label_lists.first).to have_content '家事'
      end
    end
  end

  describe '詳細表示機能' do
    context '詳細画面に遷移した場合' do
      it 'タスクに紐づいているラベルが表示される' do
        visit tasks_path
        click_on '詳細'
        expect(page).to_not have_content '仕事'
        expect(page).to_not have_content '趣味'
        expect(page).to have_content '家事'
      end
    end
  end

  describe 'ラベル検索機能' do
    before do
      FactoryBot.create(:task, :with_label, user: user, name: '掃除')
      FactoryBot.create(:task, :with_label2, user: user, name: '書類作成')
      FactoryBot.create(:task, :with_label3, user: user, name: '本屋へ行く')
    end
    context '一覧画面でラベルを選択し検索した場合' do
      it '指定したラベルがついたタスクのみが表示される' do
        visit tasks_path
        select '家事', from: 'task_label_ids'
        click_on "検索"
        labels = all('.task_label')
        expect(labels[0]).to have_content '家事'
        expect('page').to_not have_content '仕事'
        expect('page').to_not have_content '趣味'
      end
    end
  end
end