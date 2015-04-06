Rails.application.routes.draw do
  devise_for :users

  patch "users/:id", to: "users#toggle_admin", as: "toggle_admin"

  authenticate :user do
    resources :users, only: %i(index destroy toggle_admin)
    resources :tutorials, only: %i(new create edit update destroy)
  end

  get "tutorials/search", to: "tutorials#search"

  resources :tutorials, only: %i(index show) do
    resources :reviews, only: %i(index) do
      member do
        put "like", to: "reviews#upvote"
        put "dislike", to: "reviews#downvote"
      end
    end
    authenticate :user do
      resources :reviews, only: %i(create destroy)
    end
  end

  root 'tutorials#index'
end
