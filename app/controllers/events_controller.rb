# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events_past = Event.past
    @events_upcoming = Event.upcoming
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    if logged_in?
      current_user.events.build(event_params)
      current_user.save
      redirect_to events_path
    else
      redirect_to login_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
