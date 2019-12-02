class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_foreign_key :events, :users
  end
end
