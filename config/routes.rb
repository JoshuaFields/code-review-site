Rails.application.routes.draw do
  devise_for :users
  root "tutorials#index"

  get "tutorials/search", to: "tutorials#search"
  get "tags/:tag_name", to: "tutorials#index", as: "tag"
  get "newest/:newest", to: "tutorials#index", as: "newest"
  get "oldest/:oldest", to: "tutorials#index", as: "oldest"
  patch "users/:id", to: "users#toggle_admin", as: "toggle_admin"
  post "reviews/:id/upvote", to: "reviews#upvote", as: "upvote"
  post "reviews/:id/downvote", to: "reviews#downvote", as: "downvote"

  resources :users, only: %i(index destroy)
  resources :tutorials, only: %i(index show new create edit update destroy) do
    resources :reviews, only: %i(index create destroy)
  end
end
