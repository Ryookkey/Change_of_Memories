class RemovePostStatusFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :post_status, :boolean
  end
end
