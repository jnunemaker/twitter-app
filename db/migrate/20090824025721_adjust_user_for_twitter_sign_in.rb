class AdjustUserForTwitterSignIn < ActiveRecord::Migration
  def self.up
    remove_column :users, :encrypted_password
    remove_column :users, :salt
    remove_column :users, :token
    remove_column :users, :token_expires_at
    remove_column :users, :email_confirmed
    add_column :users, :screen_name, :string, :limit => 30
  end

  def self.down
    remove_column :users, :screen_name
    add_column :users, :encrypted_password, :string, :limit => 128
    add_column :users, :salt, :string, :limit => 128
    add_column :users, :token, :string, :limit => 128
    add_column :users, :token_expires_at, :datetime
    add_column :users, :email_confirmed, :boolean, :default => false, :null => false
  end
end
