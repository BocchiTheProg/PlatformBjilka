class CreateClientLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :client_likes do |t|
      t.references :client_profile, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
    add_index :client_likes, %i[client_profile_id service_id], unique: true
  end
end
