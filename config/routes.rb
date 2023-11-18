Rails.application.routes.draw do
  root 'gigs#index'

  resources :gigs, only: %i[index show]

  namespace :admin do
    resources :gigs do
      collection do
        get 'social_post', to: 'gigs#social_post'
      end
    end
    resources :venues

    root to: 'gigs#index'
  end
end
