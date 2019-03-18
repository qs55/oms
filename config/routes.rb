Rails.application.routes.draw do
	
  get 'invites/index'
  get 'organizations/index'
  get 'comments/index'
  get 'posts/index'
	get 'employees/new'
	devise_for :users, path: 'auth', controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' }
  
  	resources :users, only: [:index, :show, :destroy]
  	resources :organizations
  	resources :invites
  	
  	resources :posts do
  		resources :comments
  	end

  	

	root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
