class RenamePostsIdInFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :posts_id, :post_id
  end
end
