class RenameGrousIdToGroupIdInFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :favorites, :grous
    rename_column :favorites, :grous_id, :group_id
    add_foreign_key :favorites, :groups, column: :group_id
  end
end
