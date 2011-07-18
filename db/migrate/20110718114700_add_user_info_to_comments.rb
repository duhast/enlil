class AddUserInfoToComments < ActiveRecord::Migration
  def self.up
    rename_column :comments, :author, :author_name
    add_column :comments, :author_nick, :string
    add_column :comments, :author_image, :string
  end

  def self.down
    rename_column :comments, :author_name, :author
    remove_column :comments, :author_nick, :author_image
  end
end
