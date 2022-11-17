Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :races do
      collection do
        post :roll
      end
    end
    resources :settings, only: [:index]
  end
end
