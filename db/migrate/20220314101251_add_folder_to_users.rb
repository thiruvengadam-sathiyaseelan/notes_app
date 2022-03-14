class AddFolderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :folder_id, :integer

  end
end
