class Label < ActiveRecord::Base
  has_many :buglabelassignment ,:dependent=>:destroy
  has_many :bugs,:through=>:buglabelassignment
  belongs_to :project
  attr_accessible :created_at, :created_by, :labelname, :status, :updated_at, :updated_by,:bug_ids,:project_id
end
