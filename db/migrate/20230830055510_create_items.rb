class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      t.string :item_name,                  nell:false
      t.text :item_info,                    nell:false
      t.integer :category_id,               nell:false
      t.integer :item_status_id,            nell:false
      t.integer :shipping_fee_status_id,    nell:false
      t.integer :prefecture_id,             nell:false
      t.integer :delivery_date_id,          nell:false
      t.integer :price,                     nell:false
      t.references :user,                   null: false, foreign_key: true

      t.timestamps
    end
  end
end
