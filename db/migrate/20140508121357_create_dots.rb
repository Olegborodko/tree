class CreateDots < ActiveRecord::Migration
  def change
    create_table :dots do |t|
      t.string :name
      t.timestamps
    end
  end
end
