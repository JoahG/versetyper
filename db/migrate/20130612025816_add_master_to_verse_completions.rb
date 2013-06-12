class AddMasterToVerseCompletions < ActiveRecord::Migration
  def change
    add_column :verse_completions, :master, :boolean
  end
end
