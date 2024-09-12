class CreateRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :relations do |t|
      t.integer :follow_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
