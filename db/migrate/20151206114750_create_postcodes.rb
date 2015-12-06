class CreatePostcodes < ActiveRecord::Migration
  def change
    create_table :postcodes do |t|
      t.string :postcode
      t.string :prefecture
      t.string :city
      t.string :address

      t.timestamps null: false
    end
  end
end
