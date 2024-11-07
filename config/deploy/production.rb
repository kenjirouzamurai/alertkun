#デプロイするサーバーにsshログインする鍵の情報を記述
puts "【Alertkun】本番環境に入りました"

# サーバ情報
puts "サーバーアクセス情報は安全の為にコメントアウトしております。"
server '52.195.215.103',  user: 'ec2-user', port: 22, password: fetch(:password), roles: %w{web app db}

set :branch, 'main' #マージ前なら他のブランチでも設定可能

# RAILS_ENV の指定
set :rails_env, 'production'

# unicorn で利用する RACK_ENV の指定
set :unicorn_rack_env, 'production'

#出力するログのレベル。
set :log_level, :debug

set :pty, false
