Rails.application.routes.draw do
	get 'omniauth_callbacks/facebook'

  devise_for :users, skip: [:registrations], controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  authenticated :user do
	  root 'notes#index', as: :authenticated_root
	  resources :notes
  	resources :categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
