class CreateMembers < ActiveRecord::Migration[8.0]
  def up
    create_table :members do |t|
      t.string :name, limit: 50, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :role, null: false, default: "Basic"
      t.text :image_url
      t.references :organization, foreign_key: true, null: false
      t.timestamps
    end
  end

  def down
    drop_table :members
  end
end
