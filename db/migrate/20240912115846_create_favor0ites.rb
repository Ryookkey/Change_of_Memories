class CreateFavor0ites < ActiveRecord::Migration[6.1]
  def change
    create_table :favor0ites do |t|
      t.references :groups, null: false, foreign_key: true
      t.references :posts, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
