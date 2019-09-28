class Actor < ActiveRecord::Base
  # Relation
  has_many :events

  # Validations
  validates :id_external, presence: true
  validates :login, length: {maximum: 60}, presence: true
  validates :avatar_url, presence: true

  attr_accessor :max_streak, :last_event

  # Responsible to find or create a sanitized actor object.
  def self.create_or_get_id(actor)
    return Actor.where(id_external: actor[:id]).first_or_create!(
      id_external: actor[:id],
      login: actor[:login],
      avatar_url: actor[:avatar_url],
    ).id
  end

  # Responsible to build the query to find actors ordered by amount of events.
  def self.order_by_amount_of_events
    return self
      .joins('LEFT JOIN events ON events.actor_id = actors.id')
      .select('actors.id, actors.id_external, actors.login, actors.avatar_url, actors.login, COUNT(events.id) as event_count, events.created_at')
      .group('actors.id')
      .order('event_count DESC, events.created_at DESC, actors.login ASC')
  end

  # Responsible to return actors array ordered by streak.
  def self.order_by_streak
    actors = self.count_streak_by_actors(Actor.order(:login))
    # If the max_streak equals for two or more actors, it will sort by last_event.
    actors.sort { |a, b| (a.max_streak == b.max_streak) ? b.last_event <=> a.last_event : b.max_streak <=> a.max_streak }
  end

  private

  # Responsible to count events by actors, assigning max_streak and last_event to object instance.
  def self.count_streak_by_actors(actors)
    actors.each do |actor|
      actor_events = Event.where(actor_id: actor['id']).order(:created_at).as_json
      # All actors has at least one event.
      current_streak = 1
      actor.max_streak = 1
      actor_events.each_with_index do |event, index|
        unless actor.last_event.nil?
          # Get days diff between two dates.
          days_diff = (event['created_at'].to_date - actor.last_event.to_date).to_i

          # Events with 1 day diff occurred on consecutive dates
          if days_diff == 1
            current_streak += 1
          end

          # Update attr when current streak is higher
          if current_streak > actor.max_streak
            actor.max_streak = current_streak
          end

          # Reset current_streak to 1 in case of streak lost.
          if days_diff > 1
            current_streak = 1
          end
        end

        actor.last_event = event['created_at']
      end
    end

    return actors
  end
end