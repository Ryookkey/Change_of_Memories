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

  resources :users, only: [:index, :show, :edit, :update, :destroy], controller: 'public/users' do
    resource :relationships, only: [:create, :destroy], controller: 'public/relationships'
    get "followings" => "public/relationships#followings", as: "followings"
    get "followers" => "public/relationships#followers", as: "followers"
    get 'unsubscribe', to: 'public/users#unsubscribe'
    resources :favorites, only: [:index], controller: 'public/favorites'
  end

  resources :posts, only: [:create, :new, :show, :index, :edit, :update, :destroy], controller: 'public/posts' do
    resource :favorites, only: [:create, :destroy], controller: 'public/favorites'
    resources :comments, only: [:create, :destroy], controller: 'public/comments'
    member do
      get 'second_memo'
      patch 'second_memo'
      get 'third_memo'
      patch 'third_memo'
    end
  end

  get "search" => "public/searches#search"

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  get "" => 'homes#top', as: 'admin_homes'
end
