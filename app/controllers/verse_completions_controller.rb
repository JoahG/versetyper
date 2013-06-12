class VerseCompletionsController < ApplicationController
	def create
		@vc = VerseCompletion.new(params["verse_completion"])
		if @vc.save
			render :json => {}
		else
			render :json => {}, :status => 500
		end
	end
end