Rails.application.routes.draw do
  namespace :api do
    resources :races do
      collection do
        get :settings
        post :roll
      end
    end
  end
end
