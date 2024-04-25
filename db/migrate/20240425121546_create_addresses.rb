class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :build
      t.string :flat
      t.references :client_profile, null: true, foreign_key: true

      t.timestamps
    end
  end
end
