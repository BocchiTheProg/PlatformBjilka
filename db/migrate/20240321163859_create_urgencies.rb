class CreateUrgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :urgencies do |t|
      t.string :title

      t.timestamps
    end
  end
end
