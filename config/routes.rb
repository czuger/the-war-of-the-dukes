Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # mount MochaRails::Engine => 'mocha' unless Rails.env.production?
  get 'welcome/show'

   # mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  get '/auth/:provider/callback', to: 'sessions#create'

	# Player are created by login
  # resources :players, only: [ :index, :new, :create ]

	resources :board_histories, only: [ :show ]

	resources :pawns, only: [ :update, :destroy ]

	resources :boards, only: [ :index, :new, :create, :update ] do
		get 'setup'

		# post 'store_pawn_position'

		resource :game_actions, only: [ :show ] do
			get :phase_finished
		end

		resource :game_action_retreats, only: [ :show, :create, :update ]
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
