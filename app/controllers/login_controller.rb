class LoginController < ApplicationController

  skip_before_filter :login_required,:admin_required

  def initialize
    @projects = Project.all
    super
  end
  
  def index
     @user =User.new
   	 render "login"
  end
  
  def authenticate
    logger.info "starting index"
  	user = User.authenticate(params[:username],params[:password])
   
    if user 
      # gloabal variable for accessing the project
      project = Project.find_by_id(params[:project_id])
      session[:user_id] = user.id
      session[:username] = user.username
      session[:user] =user
      session[:project_id] = project.id
      session[:project_name] = project.projectname
    	redirect_to(bugs_path)
  	else
  	  @user =User.new
  	  @user.errors[:base] << "Login Failed"
  		render "login"
  	end

  end

  
  def logout
    sessionobj  = Session.find_by_session_id(request.session_options[:id])
    redirect_to :login
    sessionobj.destroy
    session[:user_id] = nil
  end


 

end
