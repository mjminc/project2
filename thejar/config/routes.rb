Rails.application.routes.draw do

  get 'messages/index'

  get 'messages/show'

  get 'messages/new'

  get 'messages/create'

  get 'messages/edit'

  get 'messages/update'

  get 'messages/delete'

  root to: 'sites#index'

  get '/about', to: 'sites#about'

  get '/contact', to: 'sites#contact'

  resources :users do
    resources :challenges do
      resources :messages
    end
  end


end
