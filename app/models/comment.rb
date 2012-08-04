class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bug
  attr_accessible :content, :created_at, :created_by, :status, :updated_at, :updated_by,:bugstatus
end
