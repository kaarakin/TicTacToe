class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.json :state, null: false
      t.integer :filled, null: false
      t.string :win_sym
      t.string :user_id
      t.string :current_symbol, null:false

      t.timestamps
    end
  end
end
