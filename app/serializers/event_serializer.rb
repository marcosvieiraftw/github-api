class EventSerializer < DefaultSerializer
  attribute :type do |object|
    object.event_type
  end

  attribute :actor do |object|
    ActorSerializer.new(Actor.find(object.actor_id)).serializable_hash
  end

  attribute :repo do |object|
    RepoSerializer.new(Repo.find(object.repo_id)).serializable_hash
  end

  attribute :created_at do |object|
    I18n.l(object.created_at, format: :default)
  end
end
