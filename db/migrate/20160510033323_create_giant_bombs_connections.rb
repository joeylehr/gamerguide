class CreateGiantBombsConnections < ActiveRecord::Migration
  def change
    create_table :giant_bombs_connections do |t|

      t.timestamps null: false
    end
  end
end
