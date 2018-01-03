class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.references :martian, foreign_key: true
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
