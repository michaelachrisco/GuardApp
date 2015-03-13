class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end
  end
end
