class ActsAsTaggableGem < ActiveRecord::Migration
  def self.up
    add_column :taggings, :taggable_type, :string
    execute "UPDATE `taggings` SET `taggable_type` = 'Post'"
  end

  def self.down
    remove_column :taggings, :taggable_type
  end
end
