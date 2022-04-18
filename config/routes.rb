Rails.application.routes.draw do
  devise_for :users  #ユーザー管理機能に必要なルーティング自動生成
  root to: 'items#index'  #ルートパス指定
  resources :items  #itemのアクションのルーティング自動生成
end
