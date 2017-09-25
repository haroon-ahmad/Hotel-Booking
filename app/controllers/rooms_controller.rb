class RoomsController < ApplicationController
  respond_to :html, :xml, :json, :js 
  def index
  	@rooms=Room.all
  		if params[:search]
    		@rooms = Room.search(params[:search]).order("created_at DESC")
  		else
    	@rooms = Room.all.order("created_at DESC")
  		end
          respond_to do |format|
    format.html
    format.js
    format.xml { render xml: @rooms }
  end
  end

  def show
  	@room=Room.find(params[:id])

    respond_with(@roomtype) do |format|
      format.js  { render :json => @room, :callback => params[:callback] }
      format.xml {render :xml=>@room}
  end
end
end
