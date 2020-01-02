class Species < ActiveRecord::Migration[6.0]
  def change
    create_table :species do |t|
      t.string :scientific_name, null: false, default: ''
      t.string :japanese_name, default: ''
      t.string :chinese_name, default: ''
      t.string :korean_name, default: ''
      t.string :english_name, default: ''

      t.timestamps
    end
  end
end
