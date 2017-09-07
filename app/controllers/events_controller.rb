class EventsController < ApplicationController
  JSONResource = ActiveModelSerializers::SerializableResource

  def index
    events = Event.includes(:location)
    events_json = JSONResource.new(events).as_json
    render react_component: 'Events',
           props: {
             events: events_json,
             authToken: form_authenticity_token
           }
  end

  def show
    event = Event.includes(:users, timeslots: [{ preferences: :user }])
                 .find_by_slug(params[:id])
    event_json = JSONResource.new(event, serializer: EventShowSerializer).as_json
    timeslots_json = JSONResource.new(event.timeslots).as_json
    users_json = JSONResource.new(event.users).as_json

    props = {
      event: event_json,
      timeslots: timeslots_json,
      users: users_json,
      authToken: form_authenticity_token
    }

    respond_to do |format|
      format.html { render react_component: 'Event', props: props }
      format.json { render json: props }
    end
  end
end
