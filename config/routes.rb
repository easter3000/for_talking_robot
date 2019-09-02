Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :update] do
    collection do
      get :blacklist
      patch :add_to_blacklist
      patch :remove_from_blacklist
    end
  end
end
