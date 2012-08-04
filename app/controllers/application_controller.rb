class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required,:admin_required

  helper_method :get_project_id,:get_project
  def get_project_id
    Project.find_by_id(session[:project_id]).id
  end

   def get_project
    Project.find_by_id(session[:project_id])
  end
  
  def login_required
    redirect_to("/login") if session[:user_id].blank?
  end
  
  def admin_required
    if session[:user]
      redirect_to("/logout") if session[:user].role.rolename != "Admin"
    end
  end
  
end
