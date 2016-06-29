class EventAttendeesController < ApplicationController
  before_action :find_event

def index
  @attendees = @event.attendees
end

def show
  @attendee = @event.attendees.find( params[:id] )
end

def new
  @attendee = @event.attendees.build
end

def create
  @attendee = @event.attendees.build( attendee_params )
  if @attendee.save
    @event.attendee_count += 1
    @event.attendee_update = @attendee.created_at
    @event.save
    redirect_to event_attendees_url( @event )
  else
    render :action => :new
  end
end

def edit
  @attendee = @event.attendees.find( params[:id] )
end

def update
  @attendee = @event.attendees.find( params[:id] )

  if @attendee.update( attendee_params )
    redirect_to event_attendees_url( @event )
  else
    render :action => :edit
  end

end

def destroy
  @attendee = @event.attendees.find( params[:id] )
  if @attendee.destroy
    @event.attendee_count -= 1
    @event.save
  end

  redirect_to event_attendees_url( @event )
end

def like
    @attendee = Attendee.find( params[:attendee_id] )

    like = @attendee.finy_like_by(current_user)

    if like
      # do nothing
    else
      @like = @attendee.likes.create!( :user => current_user )
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "like" }
    end
    
  end

  def unlike
    @attendee = Attendee.find( params[:attendee_id] )

    like = @attendee.finy_like_by(current_user)
    like.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "like" }
    end
  end

protected

def find_event
  @event = Event.find( params[:event_id] )
end

def attendee_params
	params.require(:attendee).permit(:name)
end

end
