Rails.application.routes.draw do

  resources :wikis do 
    resources :collaboratings, only: [:create]
    delete 'collaboratings/:user_id', to: 'collaboratings#destroy', as: :delete_collaborator
  end
  resources :charges, only: [:new, :create]
  # resources :collaboratings, only: [:create, :destroy]
  # post 'wikis/:wiki_id/collaboratings', to: 'collaboratings#create', as: :add_collaborator
  # delete 'collaboratings/:collaborating_id', to: 'collaboratings#destroy', as: :delete_collaborator

  devise_for :users do
    resources :wikis, only: [:index]
  end

  get ':user_id/wikis', to: 'wikis#mine', as: :mywikis

  root to: 'welcome#index'

end
