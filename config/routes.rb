Rails.application.routes.draw do
  devise_for :users

  resources :tutorials, only: %i(index show new create)

  resources :tutorials, only: %i(index show) do
    resources :reviews, only: %i(index create) do
    end
  end

  resources :reviews do
    member do
      put "like", to: "reviews#upvote"
      put "dislike", to: "reviews#downvote"
    end
  end

  root 'tutorials#index'

end
