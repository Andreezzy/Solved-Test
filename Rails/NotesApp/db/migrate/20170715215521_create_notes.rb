class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body
      t.boolean :flag
      t.references :category, foreign_key: true
      t.integer :num_views
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end