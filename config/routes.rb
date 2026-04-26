Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  # ゲストユーザーログインパス
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    post "users/admin_guest_sign_in", to: "users/sessions#admin_guest_sign_in"
  end

  # ログインしている時のroot(機器一覧)
  authenticated :user do
    root "devices#index", as: :authenticated_root
  end

  # ログインしていない時のroot(新規登録)
  unauthenticated do
    devise_scope :user do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :users, :devices
  resources :requests do
    member do
      patch :approve
      patch :reject
      patch :return

      get :show_pending
      get :show_history
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
