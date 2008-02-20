# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'e90370adcf3a6692a7e3f80dfd58c570'
  
  def current_controller(controller_name, name)
    if @controller.controller_name == controller_name	
		  link_to name, {:controller => controller_name}, :style => 'color:#FFF;background-color:#15a;text-decoration:none;'
		else
		  link_to name, :controller => controller_name
    end    
  end
end
