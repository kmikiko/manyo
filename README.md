テーブルスキーマ

| Model | Column | Type |
-|-|-
|user|name|string|
|user|email|string|
|user|password_digest|string|
|task|name|string|
|task|explanation|string|
|task|status|string|
|task|duedate|date|
|task|priority|string|
|label|name|string|
|task_label|task_id|string|
|task_label|label_id|string|


# herokuにデプロイする手順

- アプリのディレクトリ内でHerokuに新しいアプリケーションを作成

 heroku create

- gemfileを追加し、bundle install

gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'


- git add .  と　git commit -m”” を実行


- heroku buildpackを追加


 heroku buildpacks:set heroku/ruby
 heroku buildpacks:add --index 1 heroku/nodejs


- HerokuにPostgreSQLのアドオンも追加

heroku addons:create heroku-postgresql


- step2ブランチの変更内容をheroku のmasterブランチに反映
git push heroku step2:master

- データベース作成
heroku run rails db:migrate