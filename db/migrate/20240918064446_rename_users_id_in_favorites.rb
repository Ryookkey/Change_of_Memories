class RenameUsersIdInFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :users_id, :user_id
  end
end
