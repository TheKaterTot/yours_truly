class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.references :category, null: false

      t.timestamps
    end
  end
end
