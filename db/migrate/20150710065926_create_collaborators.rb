class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id
      t.integer :wiki_id
      t.references :wiki, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps 
    end
  end
end
