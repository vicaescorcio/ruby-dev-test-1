class CreateFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :folders do |t|
      t.string :name
      
      t.timestamps
    end
    add_index :folders, :parent_id
  end
end
