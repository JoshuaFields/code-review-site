Rails.application.routes.draw do
  devise_for :users

  patch "users/:id", to: "users#toggle_admin", as: "toggle_admin"

  resources :users, only: %i(index destroy toggle_admin)

  get "tutorials/search", to: "tutorials#search"

  resources :tutorials, only: %i(index show new create edit update destroy) do
    resources :reviews, only: %i(index) do
      member do
        put "like", to: "reviews#upvote"
        put "dislike", to: "reviews#downvote"
      end
    end
    resources :reviews, only: %i(create destroy)
  end

  root 'tutorials#index'
end
