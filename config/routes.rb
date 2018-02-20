Rails.application.routes.draw do

  get 'welcome/show'

   mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  resources :players, only: [ :index, :new, :create ] do
    resources :boards, only: [ :index, :new, :create ] do
      get 'play'
    end
  end

  get 'edit_map/edit_hexes'
  post 'edit_map/update_hexes'

  get 'edit_map/edit_top_layer'
  post 'edit_map/update_top_layer'

  get 'test/full_hex_map'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#show' # shortcut for the above

end
