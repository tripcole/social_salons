class AddWebsiteToSalons < ActiveRecord::Migration[6.0]
  def change
    add_column :salons, :website, :string
  end
end
