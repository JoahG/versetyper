class User < ActiveRecord::Base
	attr_accessible :email, :login, :password, :password_confirmation
	has_secure_password
	validates_presence_of :password, :on => :create
	has_many :verses
	has_many :verse_completions

	def wpm
		t = 0
		p = 0
		self.verse_completions.each do |vc|
			t += vc.wpm
			p += 1
		end
		if p > 0
			t/p
		else
			t
		end
	end
end