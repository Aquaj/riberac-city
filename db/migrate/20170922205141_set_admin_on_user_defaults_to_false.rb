class SetAdminOnUserDefaultsToFalse < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :admin, :boolean, default: false
  end

  def down
    # NOOP
  end
end
