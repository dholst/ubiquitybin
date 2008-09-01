ActionController::Routing::Routes.draw do |map|
  map.logout   '/logout',    :controller => 'sessions', :action => 'destroy'
  map.login    '/login',     :controller => 'sessions', :action => 'new'
  map.register '/register',  :controller => 'users', :action => 'create'
  map.signup   '/signup',    :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.home     '/home',      :controller => 'home', :action => 'stay'
  
  map.resources :users
  map.resource  :session
  map.resources :scripts

  map.script_by_username '/:username/:name', :controller => 'scripts', :action => 'show'
  map.username '/:username', :controller => 'scripts'

  map.root :controller => "home"
end
