class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :admin?

  protected

  

  def authorize 
  	unless admin?
  		redirect_to root_path
  	end
  end

  def admin?
  	session[:password] == "h0lein0ne"
  end

end
