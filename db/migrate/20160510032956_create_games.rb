class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :release_date
      t.string :alias
      t.string :image
      t.string :link
      t.string :console
      t.string :log_line
      t.integer :game_bomber_id
      t.timestamps null: false
    end
  end
end
