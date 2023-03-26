Rails.application.routes.draw do
  get 'payments/payment'
  devise_for :users
  post 'user/signup'
  post 'user/do_activate_account'
  post 'user/regenerate_active_token'
  get 'user/activate_account'
  post 'payments/create_payment'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "ihm#homepage"
end
