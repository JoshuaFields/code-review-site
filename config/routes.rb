Rails.application.routes.draw do
  devise_for :users

  get "tutorials/search", to: "tutorials#search"
  patch "users/:id", to: "users#toggle_admin", as: "toggle_admin"
  put "tutorials/:tutorial_id/reviews/:id/upvote",
    to: "reviews#upvote", as: "upvote"
  put "tutorials/:tutorial_id/reviews/:id/downvote",
    to: "reviews#downvote", as: "downvote"
  root 'tutorials#index'

  resources :users, only: %i(index destroy)
  resources :tutorials, only: %i(index show new create edit update destroy) do
    resources :reviews, only: %i(index create destroy)
  end
end
