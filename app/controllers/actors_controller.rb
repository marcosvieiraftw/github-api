class ActorsController < ApplicationController
  before_action :set_actor, only: [:update]

  # PUT /actors
  def update
    return render json: {}, status: :not_found if @actor.blank?

    @actor.attributes = {
      login: actor_params[:login],
      avatar_url: actor_params[:avatar_url]
    }

    if !@actor.login_changed? && @actor.save!
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  # GET /actors
  def list_by_amount_of_events
    @actors = Actor.order_by_amount_of_events
    render json: ActorSerializer.new(@actors).serialized_json
  end

  # GET /actors/streak
  def list_by_streak
    @actors = Actor.order_by_streak
    render json: ActorSerializer.new(@actors).serialized_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_actor
    @actor = Actor.find_by(id_external: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def actor_params
    params.permit(:id, :login, :avatar_url)
  end
end
