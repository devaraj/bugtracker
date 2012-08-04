class BugsController < ApplicationController

  @@selected_label = nil
  @@assigned_to = false
  @@found_by = false
  
  skip_before_filter :admin_required
  # GET /bugs
  # GET /bugs.json
  def index
    @notice = "ALL Issues"
    @@selected_label=nil
    @@found_by=false
    @@assigned_to=false
    get_bugs
    get_count_of_issue
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bugs }
    end
  end

  def openissue
    @notice="Open Issue"
    project_bug("Open")
  end
  def get_bugs
    @bugs =Bug.find_all_bugs_in_project(params[:page],get_project_id)
  end

  def get_count_of_issue(bugsarr=nil)
    @allopenissuse =Bug.find_status_size("Open",get_project_id,bugsarr) 
    @allclosedissuse =Bug.find_status_size("Closed",get_project_id,bugsarr) 
    @allfixedissuse = Bug.find_status_size("Fixed",get_project_id,bugsarr) 
    @allreopenedissuse = Bug.find_status_size("ReOpened",get_project_id)
    @allissuse = Bug.number_of_bugs_in_project(get_project_id)
    @assignedtomeissuse = Bug.number_assigned_to_me(session[:user_id],get_project_id)
    @assignedbymeissuse = Bug.number_assigned_by_me(session[:user_id],get_project_id)
    @labels = Label.where(:status=>"Active",:project_id=>session[:project_id])
  end

  def project_bug(status)
    if @@selected_label
      bugids = Buglabelassignment.where("label_id=#{@@selected_label}").select("bug_id").map(&:bug_id)
      @bugs =Bug.where("status='#{status}' and project_id = #{session[:project_id]} and id in (?)",bugids).page(params[:page]).per(13)
    elsif @@assigned_to
      bugids =Bug.where("assignedto_user_id=? and status !=? and project_id=? ",session[:user_id],"Inactive",get_project_id).map(&:id)
      @bugs =Bug.where("status='#{status}' and project_id = #{session[:project_id]} and id in (?)",bugids).page(params[:page]).per(13)
    elsif @@found_by
      bugids =Bug.where("assignedby_user_id=? and status !=? and project_id=? ",session[:user_id],"Inactive",get_project_id).map(&:id)
     @bugs =Bug.where("status='#{status}' and project_id = #{session[:project_id]} and id in (?)",bugids).page(params[:page]).per(13)
    else
        @bugs =Bug.where("status='#{status}' and project_id = #{session[:project_id]} ").page(params[:page]).per(13)
    end
    get_count_of_issue(bugids)
    render "index"
  end

  def closedissue
    @notice="Closed Issue"
    project_bug("Closed")
  end

  def fixedissue
    @notice="Fixed Issue"
    project_bug("Fixed")
  end
  
  def reopenedissue
    @notice="ReOpened Issue"
    project_bug("ReOpened")
  end

  def assignedme
    @notice = "Assigned To Me"
    @@selected_label =nil
    @@assigned_to = true
    @@found_by = false
    bugids =Bug.where("assignedto_user_id=? and status !=? and project_id=? ",session[:user_id],"Inactive",get_project_id).map(&:id)
    @bugs =Bug.where("assignedto_user_id=? and status !=? and project_id=?",session[:user_id],"Inactive",get_project_id).page(params[:page]).per(13)
    get_count_of_issue(bugids)
    render "index"
  end

  def assignedby
    @notice = "Assigned ByMe"
    @@selected_label =nil
    @@assigned_to = false
    @@found_by = true
    bugids =Bug.where("assignedby_user_id=? and status !=? and project_id=? ",session[:user_id],"Inactive",get_project_id).map(&:id)
    @bugs =Bug.where("assignedby_user_id=? and status !=? and project_id=?",session[:user_id],"Inactive",get_project_id).page(params[:page]).per(13)
    get_count_of_issue(bugids)
    render "index"
  end



  def bugsearch
    data = params[:search]
    @notice = "Search Results "+data
    @bugs =Bug.search(data,params[:page],get_project_id)
    get_count_of_issue
    render "index"
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
    @bug = Bug.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bug }
    end
  end

  # GET /bugs/new
  # GET /bugs/new.json
  def new
    @bug = Bug.new
    @users =Bug.get_users_project(get_project_id)
    get_count_of_issue
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bug }
    end
  end
  
 

  # GET /bugs/1/edit
  def edit
    @bug = Bug.find(params[:id])
    @users =Bug.get_users_project(get_project_id)
    @projects = get_project
    get_count_of_issue
  end

  # POST /bugs
  # POST /bugs.json
  def create
    
    if params[:bug][:bugtitle].empty? or params[:bug][:bugdescription].empty? or params[:bug][:assignedto_user_id].empty?
      @bug = Bug.new(params[:bug])
      @bug.errors[:base] << "Please Enter all the mandatory fields "
      @users = Bug.get_users_project(get_project_id)
      get_count_of_issue
      render :action=>"new"
    else
      @bug = Bug.new(params[:bug])
      Bug.save_file(params,@bug) if !params[:fileuploadpath].nil?
      @bug.project_id  = get_project_id
      @bug.assignedby_user_id = session[:user_id]
      @bug.status= "Open"
      respond_to do |format|
        if @bug.save
        format.html { redirect_to bugs_url , notice: 'Bug was successfully created.' }
        else
          format.html { render action: "new" }
          format.json { render json: @bug.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /bugs/1
  # PUT /bugs/1.json
  def update
    @bug = Bug.find(params[:id])
    Bug.save_file(params,@bug) if params[:keepold].nil? or params[:keepold].empty?
    updateparams = params
    updateparams[:bug][:fileuploadpath] = @bug.fileuploadpath
    respond_to do |format|
      if @bug.update_attributes(updateparams[:bug])
        format.html { redirect_to bugs_path, notice: 'Bug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug = Bug.find(params[:id])
    if @bug.update_attributes(:status=>"Inactive")
      redirect_to bugs_path
   end
  end

  # comments controller starting

  def addcomments
    bugforcomment = Bug.find(params[:id])
    get_count_of_issue
    @comment = Comment.new
    @comment.bug = bugforcomment
    @comments = Array.new
    @comments = Comment.find_all_by_bug_id(params[:id],:order =>"created_at DESC")
    respond_to do |format|
      format.html # addcomments.html.erb
      format.json { render json: @comment }
    end
  end

  def savecomments

    @comment = Comment.new(params[:comment])
    @comment.user = User.find(session[:user_id])
    bugforcomment = Bug.find_by_id(params[:bugid])
    if params[:bugstat] && !params[:bugstat].empty? && bugforcomment
        if bugforcomment.update_attributes(:status=>params[:bugstat])
          @notice = "Bug Fixed"
        else
          @notice = "Technical error try after some time"
        end
    end       

    @comment.bug = bugforcomment
    @comment.bugstatus = params[:bugstat]
    if @comment.save
      redirect_to addcomments_path(:id=>@comment.bug.id)
    else
      render "addcomments"
    end
  end
  
  
  # Labels creating and deleting
  def createlabel
    if !params[:labelname].nil?  and !params[:labelname].empty? and !params[:labelcolor].nil?  and !params[:labelcolor].empty?
    label = Label.new
    label.labelname = params[:labelname]
    label.labelcolor = params[:labelcolor]
    label.project = get_project
    label.status = "Active"
    label.created_by=session[:username]
    if label.save
      @manage_label =false
      @notice = "Label created Successfully"
    else
      @notice = "Error creating label"
    end
    redirect_to bugs_url
    else
    redirect_to bugs_url
    end
  end
  
  def labeldefects
    labelid = params[:labelid]
    @@selected_label = labelid
    bugids = Buglabelassignment.where("label_id=#{labelid}").select("bug_id").map(&:bug_id)
    @bugs = Bug.where("id in (?) and status!=? and project_id=#{session[:project_id]}",bugids,'Inactive').page(params[:page]).per(13)
    get_count_of_issue(bugids)
    render "index"
  end

  def managelabels
    @manage_label = true
    get_bugs
    get_count_of_issue
    render "index"
  end

   def cancellabel
    @manage_label = false
    get_bugs
    get_count_of_issue
    render "index"
  end
  
  def deletelabel
    label_id = params[:labelid]
    label = Label.find_by_id(label_id)
    @manage_label =true
    buglabel = Buglabelassignment.find_by_label_id(label_id)
      if label.destroy
        @notice = "Label deleted successfully"
      else
        @notice = "Error deleting label"
      end
    get_bugs
    get_count_of_issue
    redirect_to bugs_url
  end
  
  #file download
  
  def download
   send_file params[:filename] 
  end
    

end
