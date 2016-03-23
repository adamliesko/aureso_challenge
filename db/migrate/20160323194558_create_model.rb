class CreateModel < ActiveRecord::Migration
  def change
    unless table_exists?(:models)
      create_table :models do |t|
        t.string :name
        t.string :model_slug
        t.integer :organization_id

        t.timestamps null: false
      end

      add_foreign_key :models, :organizations
      add_index :models, :model_slug
    end
  end
end
