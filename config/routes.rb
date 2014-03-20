Events::Application.routes.draw do
	
  resources :categories

	resource :session
	get "signin" => "sessions#new"
	resources :users
	get "signup" => "users#new"

	root "events#index"

	resources :events do
		resources :registrations
		resources :likes
	end
end