class CreateOrganization < ActiveRecord::Migration
  def change
    unless table_exists?(:organizations)
      create_table :organizations do |t|
        t.string :name
        t.string :public_name
        t.string :type
        t.string :pricing_policy
        t.string :auth_token

        t.timestamps null: false
      end

      add_index :organizations, :auth_token

    end
  end
end
