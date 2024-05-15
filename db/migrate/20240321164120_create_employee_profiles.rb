class CreateEmployeeProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.datetime :date_registration
      t.decimal :rating, null: false, default: 0
      t.references :employee, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true

      t.timestamps
    end
  end
end

