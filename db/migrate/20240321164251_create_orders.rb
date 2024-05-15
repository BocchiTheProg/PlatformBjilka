class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :status, foreign_key: true
      t.references :client_profile, null: false, foreign_key: true
      # t.references :comment, foreign_key: true
      t.references :employee_profile, null: false, foreign_key: true
      t.references :urgency, null: false, foreign_key: true
      t.datetime :date_order
      t.references :service, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.integer :rating, null: false, default: 0

      t.timestamps
    end
  end
end
