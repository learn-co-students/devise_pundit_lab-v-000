class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :roles, :role
  end
end
