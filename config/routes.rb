RepoGithooks::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#index'

  resources :welcome, only: [:index]

  resources :hooks, only: :index, defaults: {format: 'json'} do
    collection do
      post :github
    end
  end
end
