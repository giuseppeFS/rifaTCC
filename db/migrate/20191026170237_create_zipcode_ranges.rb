class CreateZipcodeRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :zipcode_ranges do |t|
   	  t.string :cep
      t.string :name
      t.string :acronym
      t.string :neighborhood
      t.string :address
      t.string :number
      t.string :complement

      t.timestamps
    end
  end
end
