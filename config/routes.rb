Rails.application.routes.draw do

  get 'welcome/show'

   mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  resources :players, only: [ :index, :new, :create ] do
    resources :boards, only: [ :index, :new, :create ] do
      resources :pawns, only: [ :create, :update, :delete ]
      get 'setup'
      get 'play'
      post 'store_pawn_position'
    end
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
