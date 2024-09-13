Rails.application.routes.draw do
  namespace :users do
    get 'mypage', as: '/mypage'
    # 5行目のルーティングから
    get 'users/edit'
    get 'users/show'
    get 'users/update'
    get 'users/unsubscribe'
    get 'users/destroy'

    get 'homes/top'
    get 'homes/about'
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end
end