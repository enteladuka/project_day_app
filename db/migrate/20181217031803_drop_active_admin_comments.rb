class DropActiveAdminComments < ActiveRecord::Migration[5.1]
  def up
    drop_table :active_admin_comments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
