class Bug < ActiveRecord::Base
  
  
  belongs_to :assignedto_user,:class_name => "User"
  belongs_to :assignedby_user,:class_name => "User"
  belongs_to :project
  has_many 	 :comments
  
  has_many :buglabelassignment
  has_many :labels,:through=>:buglabelassignment
  
  attr_accessor :totallength,:maxrows,:fileupload
  attr_accessible :bugdescription, :bugtitle, :created_at, :created_by, 
  :fileuploadpath, :updated_at, :updated_by,:assignedto_user_id,:assignedby_user_id,:project_id,:status,:label_ids
 
  
 
  def self.save_file(params,obj)
      filedata =  params[:fileuploadpath]
      if filedata.nil?
        obj.fileuploadpath=nil 
      else
      filename ="C:/upload/file_#{Time.now.to_i}/"
      if !File.directory?(filename)
        FileUtils.mkdir_p(filename)
      end
      filename = filename+filedata.original_filename
      File.open(filename,"wb") do |f|
        f.write(filedata.read)
      end
      obj.fileuploadpath  = filename
    end  
  end

  def self.find_status_size(statusui,projectid,bugsarr=nil)
    qry = "project_id = #{projectid} and status ='#{statusui}'"
    if !bugsarr.nil?
      Bug.where(qry+ " and id in (?)" ,bugsarr).size
    else
      Bug.where(qry).size
    end
  end
  def self.find_all_bugs_in_project(page,projectid)
  	Bug.where("project_id=? and status != ?",projectid,'Inactive').page(page).per(13)
  end

  def self.number_of_bugs_in_project(projectid)
  	Bug.where("project_id = #{projectid} and status !='Inactive'").size
  end

  def self.number_assigned_to_me(user_id,projectid)
  	Bug.where("assignedto_user_id = #{user_id} and project_id = #{projectid} and status !='Inactive'").size
  end
  
  def self.number_assigned_by_me(user_id,projectid)
    Bug.where("assignedby_user_id = #{user_id} and project_id = #{projectid} and status !='Inactive'").size
  end

  def self.assigned_to_me(user_id,projectid)
  	Bug.where("assignedto_user_id = #{user_id} and project_id = #{projectid} and status !='Inactive'")
  end

  def self.search(data,page,projectid)
  	number = data.to_i
  	data = "%"+data+"%"
  	Bug.where("(bugdescription like ? OR bugtitle like ? OR id like ?) and project_id =? and status <> ?",data,data,number,projectid,"'Inactive'").page(page).per(13)
  end

  def self.get_users_project(projectid)
    User.find(UserAssignment.where("project_id=?",projectid).select(:user_id).map(&:user_id))
  end
end

