Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  namespace :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get 'unsubscribe', to: 'users#unsubscribe'
      resources :favorites, only: [:index]
    end

    resources :posts, only: [:create, :new, :show, :index, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      member do
        get 'second_memo'
        patch 'second_memo'
        get 'third_memo'
        patch 'third_memo'
      end
    end

    get "search" => "searches#search"
  end

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  get "" => 'homes#top', as: 'admin_homes'
end
