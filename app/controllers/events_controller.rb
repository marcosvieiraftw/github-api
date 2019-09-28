class EventsController < ApplicationController
  before_action :set_events_by_actor, only: [:list_by_actor]

  # GET /events
  def index
    @events = Event.order(:id_external)
    render json: EventSerializer.new(@events).serialized_json
  end

  # POST /events
  def create
    @event = Event.new(
      id_external: event_params[:id],
      event_type: event_params[:type],
      created_at: event_params[:created_at]
    )
    @event.actor_id = Actor.create_or_get_id(event_params[:actor])
    @event.repo_id = Repo.create_or_get_id(event_params[:repo])

    if @event.save
      render json: {}, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  # GET /events/actors/{actor_id}
  def list_by_actor
    unless @events.empty?
      render json: EventSerializer.new(@events).serialized_json
    else
      render json: {}, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_events_by_actor
    @events = Event.joins(:actor).where(actors: { id_external: params[:actor_id] }).order(:id_external)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.permit(
      :id,
      :type,
      :created_at,
      actor: [ :id, :login, :avatar_url ],
      repo: [ :id, :name, :url ],
      model: [:event]
    )
  end
end
