class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.date :created_at
      t.string :created_by
      t.date :updated_at
      t.string :updated_by
      t.references :role

      t.timestamps
    end
    add_index :users, :role_id
  end
end
