Rails.application.routes.draw do
  namespace :api do
    resources :races do
      get :settings, on: :collection
    end
  end
end
