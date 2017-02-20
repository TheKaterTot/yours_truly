class CreateSharedLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_letters do |t|
      t.references :user
      t.references :letter

      t.timestamps
    end
  end
end
