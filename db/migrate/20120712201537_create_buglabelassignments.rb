class CreateBuglabelassignments < ActiveRecord::Migration
  def change
    create_table :buglabelassignments do |t|
      t.integer :bug_id
      t.integer :label_id

      t.timestamps
    end
  end
end
