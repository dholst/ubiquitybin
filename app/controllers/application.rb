# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
    
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3a6f8d8910db9d1fed7cd498a354f123'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
  
  def four_o_four
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end

  def four_twenty_two
    render :file => "#{RAILS_ROOT}/public/422.html", :status => 422
  end
end
