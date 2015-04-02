Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :tutorials, only: %i(new create)
  end

  resources :tutorials, only: %i(index show) do
    resources :reviews, only: %i(index) do
      member do
        put "like", to: "reviews#upvote"
        put "dislike", to: "reviews#downvote"
      end
    end
    authenticate :user do
      resources :reviews, only: %i(create)
    end
  end

  root 'tutorials#index'

end
