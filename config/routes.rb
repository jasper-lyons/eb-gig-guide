Rails.application.routes.draw do
  root 'gigs#index'

  resource :gig, only: %i[index show]

  namespace :admin do
    resources :gigs

    root to: 'gigs#index'
  end
end
