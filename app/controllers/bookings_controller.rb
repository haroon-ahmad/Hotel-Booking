class BookingsController < ApplicationController
	before_filter :authorize
	def booking_params
    	params.require(:booking).permit(:user_id,:checkin, :checkout, :persons,:room_id)
    end
      def index
     
      @booking=Booking.where(user_id: current_user.id)
      
    end

  def new
  		@booking=Booking.new
  		@room=Room.new

  end
  def create
  	@booking=Booking.new(booking_params)
    @room2=Room.find(@booking.room_id)
    #flash[:notice]=@room2.count
  	if @booking.checkin>@booking.checkout
  	
  			render "new"
  			flash[:notice]="Fix dates"
  	elsif @booking.checkin<Date.today

      render "new"
      flash[:notice]="fix dates"
  
  elsif @room2.count<1
    render "new" 
    flash[:notice]="No rooms"

  elsif @booking.room_id==" "
  	
  		render "new",:notice=>"select room"
  
  	else	
  	@booking.user_id ||= current_user.id  
		if @booking.save
      @room2.update_attributes(:count => @room2.count-1)
			#redirect_to booking_path(@booking), :notice => "Confirm Your Booking"
			redirect_to action: "show" ,id: @booking.id
		else
		 render "new"
		#redirect_to root_url
		end
	end	
  end

  def show
  	@booking=Booking.find(params[:id])
  	@room=Room.find(@booking.room_id)
  end

  def edit
      @booking=Booking.find(params[:id])
    end

  def update
    @booking=Booking.find(params[:id])
    if @booking.update_attributes(booking_params)
      redirect_to action: "show", id:@booking.id
    else
      render "edit"
    end
  end

  def confirm_booking
  	@booking=Booking.find(params[:id])
  	@booking.update_attributes(:confirm => true)
  	redirect_to root_url,:notice=>"Booking Confirmed"
  end

def destroy
   @booking=Booking.find(params[:id])
    @booking.destroy
    #redirect_to bookings_path, :notice =>"Your post has been deleted"

    respond_to do |format|
      format.html { redirect_to bookings_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end

  end

end
