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