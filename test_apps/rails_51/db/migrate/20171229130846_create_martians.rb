class CreateMartians < ActiveRecord::Migration[5.1]
  def change
    create_table :martians do |t|
      t.string :name
      t.integer :age

      t.timestamps
    end
  end
end
