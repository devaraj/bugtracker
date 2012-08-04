class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :labelname
      t.string :status
      t.date :created_at
      t.string :created_by
      t.date :updated_at
      t.string :updated_by

      t.timestamps
    end
  end
end
