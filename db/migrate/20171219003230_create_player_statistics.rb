class CreatePlayerStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :player_statistics do |t|
      t.string :statistic
      t.string :player_tag
      t.string :discord_tag
      t.integer :initial_value
      t.integer :final_value

      t.timestamps null: false
    end
  end
end
