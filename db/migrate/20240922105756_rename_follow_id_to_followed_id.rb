class RenameFollowIdToFollowedId < ActiveRecord::Migration[6.1]
  def change
    rename_column :relations, :follow_id, :followed_id
  end
end
