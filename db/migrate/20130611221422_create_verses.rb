class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.string :ref
      t.string :content

      t.timestamps
    end
  end
end
