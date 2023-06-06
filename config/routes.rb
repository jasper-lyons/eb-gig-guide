Rails.application.routes.draw do
  root 'gigs#index'

  resources :gigs, only: %i[index show]

  namespace :admin do
    resources :gigs
    resources :venues

    root to: 'gigs#index'
  end
end
