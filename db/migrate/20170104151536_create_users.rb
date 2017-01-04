class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :address
      t.string :tel

      t.timestamps
    end
  end
end
