class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :posts, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
