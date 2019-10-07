Rails.application.routes.draw do

  # mount MochaRails::Engine => 'mocha' unless Rails.env.production?
  get 'welcome/show'

   # mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  get '/auth/:provider/callback', to: 'sessions#create'

	# Player are created by login
  # resources :players, only: [ :index, :new, :create ]

	resources :pawns, only: [ :update, :destroy ]

	resources :boards, only: [ :index, :new, :create, :update ] do
		get 'setup'
		get 'movement'
		get 'fight'
		get 'phase_finished'

		# post 'store_pawn_position'
	end

	get '/board/map_data', to: 'boards#map_data'

  namespace :edit_map do
    get 'edit_hexes'
    post 'update_hexes'

    get 'edit_top_layer'
    post 'update_top_layer'

		get 'edit_rivers'

    get 'full_hex_map'
    get '/', action: 'full_hex_map'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#show' # shortcut for the above

end
