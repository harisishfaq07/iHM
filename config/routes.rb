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
  resources :stripe_accounts

  post 'packages/create_package'
  post 'packages/export_package'

  get 'payments/payment'
  get 'ihm/dashboard'
  get 'user/new_user'
  post 'user/create_new_user'
  delete 'user/delete_user'
  post 'user/signup'
  post 'user/do_activate_account'
  post 'user/regenerate_active_token'
  get 'user/activate_account'
  get 'user/verified_users'
  get 'user/view_user'
  get 'user/unapproved_users'
  get 'user/unpaid_users'
  post 'user/send_regenerate_active_token_email'
  post 'payments/create_payment'

  get 'payments_track/all_payments'
  get 'payments_track/up_coming_payments'
  post 'payments_track/send_payment_reminder'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  # devise_for :users, controllers: {
  #       sessions: 'users/sessions' do
  #         post 'login/users/sessions'
  #       end
  #     }
end
