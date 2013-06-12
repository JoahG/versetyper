class AddUserIdToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :user_id, :integer
  end
end
