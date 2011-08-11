class RemoveOpenid < ActiveRecord::Migration
  def self.up
    begin
      drop_table "open_id_authentication_associations"
      drop_table "open_id_authentication_nonces"
    rescue => e
      puts "Error occured, but we don't care... (#{e})"
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
