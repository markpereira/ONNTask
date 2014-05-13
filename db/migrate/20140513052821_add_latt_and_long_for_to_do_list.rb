class AddLattAndLongForToDoList < ActiveRecord::Migration
  def change
    add_column :todo_lists, :latitude, :float
    add_column :todo_lists, :longitude, :float
  end
end
