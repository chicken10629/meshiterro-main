Rails.application.routes.draw do
  #URLをadmin/sign_inでログイン画面にしたい。
  #管理者側では新規登録とパスワード機能を無効化したいのでルーティングをスキップ
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resource :users, only: [:destroy] #削除機能しか実装してない
  end
 

  scope module: :public do #この記述でコントローラーはpublicに配置されるが、URLパスからはpublicは除外される
    #通常はURLパスを参照するらしいが、この記述はモジュール名であるpublicを使ってディレクトリを参照している
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
  end
end
