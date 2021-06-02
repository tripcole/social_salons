class CreateSalons < ActiveRecord::Migration[6.0]
  def change
    create_table :salons do |t|
      t.string :name
      t.string :description
      t.string :salon_type
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :address

      t.timestamps
    end
  end
end
