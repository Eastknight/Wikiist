Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]

  devise_for :users do
    resources :wikis, only: [:index]
  end

  get ':user_id/wikis', to: 'wikis#mine', as: :mywikis

  root to: 'welcome#index'

end
