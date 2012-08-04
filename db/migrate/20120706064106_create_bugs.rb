class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :bugtitle
      t.text :bugdescription
      t.string :fileuploadpath
      t.references :assignedto_user
      t.references :assignedby_user
      t.references :project
      t.date :created_at
      t.string :created_by
      t.date :updated_at
      t.string :updated_by
 
      t.timestamps
    end
    add_index :bugs, :assignedto_user_id
    add_index :bugs, :assignedby_user_id
    add_index :bugs, :project_id
  end
end
