class ModelType < ActiveRecord::Migration
  unless table_exists?(:model_types)
    create_table :model_types do |t|
      t.string :name
      t.string :model_type_slug
      t.string :model_type_code
      t.integer :base_price
      t.integer :model_id

      t.timestamps null: false
    end

    add_foreign_key :model_types, :models
    add_index :model_types, :model_type_slug
    add_index :model_types, :model_type_code

  end
end
