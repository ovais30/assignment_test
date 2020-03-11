Rails.application.routes.draw do
  get 'tweets/index'
  get 'tweets/create'
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    # sessions: 'admin/sessions',
    registrations: 'user/registrations',
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
  }


  resources :tweets
end
