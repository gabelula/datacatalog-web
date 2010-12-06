DatacatalogWeb::Application.routes.draw do
  resources :data_records do
    resource :favorite
    resource :rating
    resources :notes
    resources :comments do
      resources :votes
    end
    resource :wiki
  end

  resources :organizations
  namespace :admin do
    resources :organizations
    resources :data_records
    resources :users
    resources :contact_submissions
  end

  resources :users
  resource :profile
  resource :user_session
  match '/' => 'main#dashboard'
  match 'about' => 'main#about', :as => :about
  match 'blog' => 'main#blog', :as => :blog
  match 'confirm/:token' => 'users#confirm', :as => :confirm
  match 'contact' => 'contact#index', :as => :contact
  match 'contact/submit' => 'contact#submit', :as => :contact_submission
  match 'dashboard' => 'main#dashboard', :as => :dashboard
  match 'forgot' => 'password_resets#new', :as => :forgot
  match 'reset/attempt' => 'password_resets#update', :as => :perform_reset
  match 'reset/:token' => 'password_resets#edit', :as => :reset
  match 'search' => 'search#index', :as => :search
  match 'forgot/sent' => 'password_resets#create', :as => :send_reset
  match 'signin' => 'user_sessions#new', :as => :signin
  match 'signout' => 'user_sessions#destroy', :as => :signout
  match 'signup' => 'users#new', :as => :signup
  match 'data/:slug' => 'data#show', :as => :source
  match 'data/:slug/docs/create' => 'data#create_doc', :as => :source_create_doc
  match 'data/:slug/docs' => 'data#docs', :as => :source_docs
  match 'data/:slug/docs/edit' => 'data#edit_docs', :as => :source_edit_docs
  match 'data/:slug/docs/:id' => 'data#show_doc', :as => :source_show_doc
  match 'data/:slug/docs/:id/update' => 'data#update_doc', :as => :source_update_doc
  match 'data/:slug/usages' => 'data#usages', :as => :source_usages
  match '/:controller(/:action(/:id))'
end
