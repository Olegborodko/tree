class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :dot_id
      t.integer :left_index
      t.integer :right_index
      t.timestamps
    end
  end
end
