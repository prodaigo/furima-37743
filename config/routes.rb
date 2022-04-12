Rails.application.routes.draw do
  root to: 'items#index'  #ルートパス指定
  resources :items, only: :index  #itemのアクションのルーティング自動生成
end
