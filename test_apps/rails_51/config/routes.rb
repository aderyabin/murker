Rails.application.routes.draw do
  namespace :v1 do
    resources :martians do
      resources :pets
    end
  end
end
