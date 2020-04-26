Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :races do
      collection do
        get :settings
        post :roll
        post 'new', to: 'races#new_race'
      end
    end
  end
end
