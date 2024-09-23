class RenameGroupsIdToGroupIdInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :groups_id, :group_id
  end
end
