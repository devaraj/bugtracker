class User < ActiveRecord::Base
  belongs_to :role 
 
  has_many :user_assignments
  has_many :projects , :through =>  :user_assignments

  attr_accessible :created_at, :created_by, :email, :password, :updated_at, :updated_by, :username,:role_id,:project_ids
  validate :username ,:presence => true

  def self.authenticate (username="",password="")
    logger.info "#{username}    #{password}"
  	user = User.find_by_username(username)
  	if user and user.password == password
  		user
  	else
  		nil
  	end

  end

  
end
