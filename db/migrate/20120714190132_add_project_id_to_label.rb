class AddProjectIdToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :project_id, :integer
  end
end
