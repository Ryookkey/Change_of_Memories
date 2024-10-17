class AddTitlePostStatusToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :title_post_status, :boolean, default: false, null: false
  end
end
