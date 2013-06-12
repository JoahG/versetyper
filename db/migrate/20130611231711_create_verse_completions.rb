class CreateVerseCompletions < ActiveRecord::Migration
  def change
    create_table :verse_completions do |t|
      t.integer :user_id
      t.integer :verse_id
      t.integer :wpm

      t.timestamps
    end
  end
end
