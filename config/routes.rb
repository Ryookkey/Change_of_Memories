Rails.application.routes.draw do

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'mypage' => 'public/users#mypage'
  
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :posts
  resources :favorite, only: [:index, :create, :destroy]
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
  end

  namespace :users do
    get 'unsubscribe'
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