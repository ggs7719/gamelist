class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @q = Event.search(params[:q])
    @events = @q.result(distinct: true).page(params[:page]).per(5).order("id DESC")
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)

    @event.user = current_user

    if @event.save
       redirect_to events_url
    else
      render :action => :new
    end
    flash[:notice] = "成功新增資料！"
  end

  def update
    @event = Event.find(params[:id])
    if params[:_remove_logo] == "1"
      @event.logo = nil
    end
    if @event.update(event_params)
       redirect_to event_url(@event)
    else
      render :action => :edit
    end
    flash[:notice] = "成功更新資料！"
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
    flash[:alert] = "成功刪除資料！"
  end

  def subscribe
    @event = Event.find( params[:id] )

    subscription = @event.finy_subscription_by(current_user)

    if subscription
      # do nothing
    else
      @subscription = @event.subscriptions.create!( :user => current_user )
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "subscription" }
    end
    
  end

  def unsubscribe
    @event = Event.find( params[:id] )

    subscription = @event.finy_subscription_by(current_user)
    subscription.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "subscription" }
    end
  end

  private

  def event_params
  params.require(:event).permit(:name, :logo, :description, :status, :category_id)
  end
end
