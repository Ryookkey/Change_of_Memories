Rails.application.routes.draw do

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  namespace :public do
    get 'mypage', to: 'users#show'

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    get 'users/unsubscribe', to: 'public/users#unsubscribe'
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end


  resources :posts
  resources :favorites, only: [:index, :create, :destroy]


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