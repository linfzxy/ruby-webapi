Rails.application.routes.draw do
  get 'categories', to: 'categories#get'
  get 'videos', to: 'videos#get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
