Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    resources :products, only:[:show,:index,:create]

    root 'welcome#index'
    devise_for :users , controllers: {sessions: "sessions"}

  #    namespace :shopping do
  #     resources :cart_items
  # end
    
	 resource :cart, only: [:show] do
	  put 'add/:product_id', to: 'carts#add', as: :add_to
	  put 'remove/:product_id', to: 'carts#remove', as: :remove_from
	end
  
  get '/wishlists' => "wishlists#index"
  post '/wishlists' => "wishlists#create"
  delete '/wishlists/:id' => "wishlists#destroy"

end
