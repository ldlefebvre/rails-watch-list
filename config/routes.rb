Rails.application.routes.draw do
  resources :lists, only: [:index, :show, :new, :create]
  get "up" => "rails/health#show", as: :rails_health_check
  # A user can see all the lists
  # GET "lists"
  # A user can see the details of a given list and its name
  # GET "lists/42"
  # A user can create a new list
  # GET "lists/new"
  # POST "lists"
end


# Rails.application.routes.draw do
#   resources :restaurants do
#     resources :reviews, only: [:index, :new, :create]
#   end
#   resources :reviews, only: [:show, :edit, :update, :destroy]
# end
