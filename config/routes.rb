Rails.application.routes.draw do
  root "ihm#homepage"
  
  devise_for :users, controllers: {sessions: 'sessions'}

  devise_scope :user do
    post "sessions/login"
  end
  
  namespace :admin do
        get '/dashboard' , to: 'admins#admin_dashboard'
  end

  resources :packages 
  post 'packages/create_package'
  post 'packages/export_package'

  get 'payments/payment'
  get 'ihm/dashboard'
  post 'user/signup'
  post 'user/do_activate_account'
  post 'user/regenerate_active_token'
  get 'user/activate_account'
  post 'payments/create_payment'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  # devise_for :users, controllers: {
  #       sessions: 'users/sessions' do
  #         post 'login/users/sessions'
  #       end
  #     }
end
