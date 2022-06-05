class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.integer :stars
      t.integer :last_commit
      t.string :url
      t.references :category, nul: false, foreign_key: true
      t.timestamps
    end
  end
end
