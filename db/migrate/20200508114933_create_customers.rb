class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :organisation_name, unique: true
      t.string :address
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.string :phone_number

      t.integer :user_id

      t.timestamps
    end
    add_index :customers, :organisation_name, unique: true
  end
end
