class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :projectname
      t.text :projectdescription
      t.date :projectstartdate
      t.date :projectenddate
      t.string :status
      t.date :created_at
      t.string :created_by
      t.date :updated_at
      t.string :updated_by

      t.timestamps
    end
  end
end
