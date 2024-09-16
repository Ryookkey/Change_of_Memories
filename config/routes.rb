Rails.application.routes.draw do

  namespace :public do
    resources :posts, only: [:create, :new, :show, :index, :edit, :update, :destroy]
    resources :favorites, only: [:index, :create, :destroy]

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get 'users/unsubscribe', to: 'public/users#unsubscribe'
    end
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