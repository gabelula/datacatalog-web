ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "home", :action => "dashboard"
  map.dashboard "dashboard", :controller => "home", :action => "dashboard"
  map.about "about", :controller => "home", :action => 'about'
  
  map.signout "signout", :controller => "user_sessions", :action => "destroy"
  map.signin "signin", :controller => "user_sessions", :action => "new"
  map.signup "signup", :controller => "users", :action => "new"
  map.confirm 'confirm/:token', :controller => 'users', :action => "confirm"
  
  map.resources :users
  map.resource :profile, :controller => "users" do |profile|
    profile.resources :keys
  end
  map.resource :user_session
  
  map.contact "contact", :controller => 'contact', :action => 'index'
  map.contact_submission "contact/submit", :controller => 'contact', :action => 'submit'
  
  map.submit "submit", :controller => 'submit', :action => 'index'
  map.data_submission "submit/submit", :controller => 'submit', :action => 'submit'

  map.search "search", :controller => "search", :action => "index"

  map.browse "browse", :controller => "browse", :action => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
