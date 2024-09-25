class ChangeDefaultFirstPostStatusInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :first_post_status, from: true, to: false
    change_column_null :posts, :first_post_status, false
    
    change_column_default :posts, :second_post_status, from: true, to: false
    change_column_null :posts, :second_post_status, false
    
    change_column_default :posts, :third_post_status, from: true, to: false
    change_column_null :posts, :third_post_status, false
  end
end
