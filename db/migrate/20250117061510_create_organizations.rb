class CreateOrganizations < ActiveRecord::Migration[8.0]
  def up
    create_table :organizations do |t|
      t.string :name, limit: 50, null: false
      t.timestamps
    end
  end

  def down
    drop_table :organizations
  end
end
