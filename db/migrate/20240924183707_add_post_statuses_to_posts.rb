class AddPostStatusesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :first_post_status, :boolean, default: true
    add_column :posts, :second_post_status, :boolean, default: true
    add_column :posts, :third_post_status, :boolean, default: true
  end
end
