class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :type
      t.string :license_plate
      t.integer :year
      t.float :price
      t.integer :garage_id
      t.integer :user_id
    end
  end
end
