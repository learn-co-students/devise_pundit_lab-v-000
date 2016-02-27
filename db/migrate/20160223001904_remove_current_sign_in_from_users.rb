class RemoveCurrentSignInFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip, :integer  
  end
end
