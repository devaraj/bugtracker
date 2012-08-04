class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :rolename
      t.date :created_at
      t.string :created_by
      t.date :updated_at
      t.string :updated_by

      t.timestamps
    end
  end
end
