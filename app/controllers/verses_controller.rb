class VersesController < ApplicationController
  def new
  	@verse = Verse.new
  end

  def create
	@verse = Verse.new(params[:verse])
	if @verse.save
		redirect_to root_url
	else
		render "new"
	end
  end

  def type
  	@verse = Verse.find(params[:id])
  end

  def master
    @verse = Verse.find(params[:id])
  end
end
