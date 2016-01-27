Rails.application.routes.draw do
 
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    resources :products, only:[:show,:index,:create]

    root 'welcome#index'
    devise_for :users
   
end