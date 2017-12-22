Rails.application.routes.draw do
  get 'test/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'test#show' # shortcut for the above

end
