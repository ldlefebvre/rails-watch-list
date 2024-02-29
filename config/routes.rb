Rails.application.routes.draw do
  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:destroy]

  resources :movies, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end


# Rails.application.routes.draw do
#   resources :restaurants do
#     resources :reviews, only: [:index, :new, :create]
#   end
#   resources :reviews, only: [:show, :edit, :update, :destroy]
# end
