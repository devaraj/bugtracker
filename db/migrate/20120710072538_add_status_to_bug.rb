class AddStatusToBug < ActiveRecord::Migration
  def change
    add_column :bugs, :status, :string
  end
end
