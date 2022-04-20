Rails.application.routes.draw do
  devise_for :users  #ユーザー管理機能に必要なルーティング自動生成
  root to: 'items#index'  #ルートパス指定
  resources :items do  #itemのアクションのルーティング自動生成
    resources :purchases, only: [:index, :create]
  end
end
