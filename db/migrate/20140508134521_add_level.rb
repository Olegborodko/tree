class AddLevel < ActiveRecord::Migration
  def change
  	add_column(:relations, :level, :integer)
  end
end
