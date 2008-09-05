ActionController::Routing::Routes.draw do |map|
  map.logout   '/logout',    :controller => 'sessions', :action => 'destroy'
  map.login    '/login',     :controller => 'sessions', :action => 'new'
  map.register '/register',  :controller => 'users', :action => 'create'
  map.signup   '/signup',    :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.home     '/home',      :controller => 'home', :action => 'stay'
  map.terms    '/terms',     :controller => 'terms', :action => 'index', :conditions => { :method => :get }
  map.contact  '/contact',   :controller => 'contact', :action => 'index', :conditions => { :method => :get }

  map.resources :users
  map.resource  :session
  map.resources :scripts

  map.users_script           '/:username/:name',         :controller => 'scripts', :action => 'show',  :conditions => { :method => :get }
  map.formatted_users_script '/:username/:name.:format', :controller => 'scripts', :action => 'show',  :conditions => { :method => :get }
  map.username               '/:username',               :controller => 'scripts', :action => 'index', :conditions => { :method => :get }

  map.root :controller => "home"
end
