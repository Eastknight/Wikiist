class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user, index: true
      t.string :slug

      t.timestamps
    end
    add_index :wikis, :slug, unique: true
  end
end
