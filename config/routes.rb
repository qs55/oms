Rails.application.routes.draw do
	
  get 'posts/index'
	get 'employees/new'
	devise_for :users, path: 'auth', controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  
  	resources :users, only: [:index, :show, :destroy]
  	
  	resources :posts
  	

	root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
