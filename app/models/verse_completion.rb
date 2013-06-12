class VerseCompletion < ActiveRecord::Base
  attr_accessible :user_id, :verse_id, :wpm, :master
  belongs_to :user
  belongs_to :verse
end
