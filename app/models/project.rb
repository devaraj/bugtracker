class Project < ActiveRecord::Base
	has_many :user_assignments
	has_many :users ,:through => :user_assignments
  	attr_accessible :created_at, :created_by, :projectdescription, :projectenddate, :projectname, :projectstartdate, :status, :updated_at, :updated_by
  	validates_presence_of :projectname
end
