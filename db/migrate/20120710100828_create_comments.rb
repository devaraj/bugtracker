class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user
      t.references :bug
      t.date :created_at
      t.date :updated_at
      t.string :created_by
      t.string :updated_by
      t.string :status

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :bug_id
  end
end
