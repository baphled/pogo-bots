class CreateRgbLists < ActiveRecord::Migration[5.1]
  def change
    create_table :rgb_lists do |t|
      t.string :team
      t.string :r
      t.string :g
      t.string :b
    end
  end
end
