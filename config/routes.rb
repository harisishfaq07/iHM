require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

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
  get 'user/locked_user'
  get 'user/edit_profile'
  get 'user/register_family'
  get 'user/add_family_members'
  post 'user/do_family_register'
  post 'user/do_add_family_members'
  get 'user/view_member'
  post 'user/do_edit_profile'
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


get 'tasks/new'
post 'tasks/create'
get 'tasks/user_schedule'


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
