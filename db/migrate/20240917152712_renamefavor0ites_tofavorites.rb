class Renamefavor0itesTofavorites < ActiveRecord::Migration[6.1]
  def change
    rename_table :favor0ites, :favorites
  end
end
