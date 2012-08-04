class Buglabelassignment < ActiveRecord::Base
  belongs_to :bug
  belongs_to :label
end
