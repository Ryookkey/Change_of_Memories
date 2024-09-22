Rails.application.routes.draw do

  namespace :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get 'unsubscribe', to: 'users#unsubscribe'
    end

    resources :posts, only: [:create, :new, :show, :index, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    get "search" => "searches#search"

  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :admin do
    get '' => 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end