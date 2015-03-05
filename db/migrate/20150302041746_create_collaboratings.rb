class CreateCollaboratings < ActiveRecord::Migration
  def change
    create_table :collaboratings do |t|
      t.integer :user_id
      t.integer :wiki_id
    end
    add_index :collaboratings, :user_id
    add_index :collaboratings, :wiki_id
  end
end
