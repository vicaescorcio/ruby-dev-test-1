class AddFolderIdToAssets < ActiveRecord::Migration[5.1]
  def self.up 
    add_column :assets, :folder_id, :integer
    add_column :folders, :parent_id, :integer
    add_index :assets, :folder_id
  end
  
  def self.down 
    remove_column :assets, :folder_id
    remove_column :folders, :parent_id
  end
end
