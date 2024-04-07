class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :street
      t.string :build

      t.timestamps
    end
  end
end
