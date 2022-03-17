class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :name, null: false
      t.string :content
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
