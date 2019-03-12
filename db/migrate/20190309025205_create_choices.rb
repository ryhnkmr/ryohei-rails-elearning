class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.integer :word_id
      t.string :content
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
