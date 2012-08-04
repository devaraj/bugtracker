class AddBugstatusToComments < ActiveRecord::Migration
  def change
    add_column :comments, :bugstatus, :string
  end
end
