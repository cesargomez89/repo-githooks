RepoGithooks::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#index'
  resources :welcome, only: [:index] do
    collection do
      get :git_hook
    end
  end

  resources :hooks, except: :all do
    collection do
      post :github
    end
  end
end
