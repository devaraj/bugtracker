class AddLabelcolorToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :labelcolor, :string
  end
end
