class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :title
      t.text :first_memo
      t.text :second_memo
      t.text :third_memo
      t.boolean :post_status

      t.timestamps
    end
  end
end
