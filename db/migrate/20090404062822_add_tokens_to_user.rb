class AddTokensToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :atoken, :string
    add_column :users, :asecret, :string
  end

  def self.down
    remove_column :users, :atoken
    remove_column :users, :asecret
  end
end
