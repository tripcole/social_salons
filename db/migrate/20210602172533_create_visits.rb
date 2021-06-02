class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.date :visit_date
      t.integer :user_id
      t.integer :salon_id
      t.integer :rating
      t.string :comment
      t.string :image
      t.integer :likes_count

      t.timestamps
    end
  end
end
