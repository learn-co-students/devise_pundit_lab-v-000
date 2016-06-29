class ChangeUsers < ActiveRecord::Migration
  def change
    def change
      change_column :users, :role, :integer, default: 0
    end
  end
end
