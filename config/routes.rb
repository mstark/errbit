Errbit::Application.routes.draw do

  devise_for :users

  # Hoptoad Notifier Routes
  match '/notifier_api/v2/notices' => 'notices#create'
  match '/deploys.txt' => 'deploys#create'

  resources :notices, :only => [:show]
  resources :deploys, :only => [:show]
  resources :users
  resources :errs,    :only => [:index]

  resources :apps, :except => [:show] do
    resources :errs do
      resources :notices
      member do
        put :resolve
        post :create_issue
        delete :unlink_issue
        post :create_comment
        delete :destroy_comment
      end
    end

    resources :deploys, :only => [:index]
  end
  match "/apps/:id", :to => redirect("/apps/%{id}/errs"), :as => :app

  devise_for :users

  root :to => 'apps#index'

end

