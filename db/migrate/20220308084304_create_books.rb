class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :youtube_id, null: false
      t.timestamps
    end
  end
end