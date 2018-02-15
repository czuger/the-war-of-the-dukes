Rails.application.routes.draw do

  mount MochaRails::Engine => 'mocha' unless Rails.env.production?

  get 'edit/show'
  post 'edit/update'

  get 'test/show'
  get 'test/full_hex_map'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'test#show' # shortcut for the above

end
