class Verse < ActiveRecord::Base
  obfuscate_id

  attr_accessible :content, :ref, :user_id
  belongs_to :user
  has_many :verse_completions
end
