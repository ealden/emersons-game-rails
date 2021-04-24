Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :races do
      collection do
        post :roll
        post 'new', to: 'races#new_race'
      end
    end
    resources :settings, only: [:index]
  end
end
