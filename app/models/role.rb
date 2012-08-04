class Role < ActiveRecord::Base
  attr_accessible :created_at, :created_by, :rolename, :updated_at, :updated_by
end
