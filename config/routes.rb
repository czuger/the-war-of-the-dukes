Rails.application.routes.draw do

  mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  get 'edit_map/edit_hexes'
  post 'edit_map/update_hexes'

  get 'edit_map/edit_roads'
  post 'edit_map/update_roads'

  get 'test/show'
  get 'test/full_hex_map'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'test#show' # shortcut for the above

end
