Rails.application.routes.draw do

  # mount MochaRails::Engine => 'mocha' unless Rails.env.production?
  get 'welcome/show'

   # mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :players, only: [ :index, :new, :create ]

	resources :boards, only: [ :index, :new, :create, :update ] do
		resources :pawns, only: [ :create, :update, :destroy ]

		get 'setup'
		get 'movement'
		get 'fight'

		# post 'store_pawn_position'
	end

  namespace :edit_map do
    get 'edit_hexes'
    post 'update_hexes'

    get 'edit_top_layer'
    post 'update_top_layer'

    get 'full_hex_map'
    get '/', action: 'full_hex_map'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#show' # shortcut for the above

end
