class Repo < ActiveRecord::Base
  # Relation
  has_many :events

  # Validations
  validates :id_external, presence: true
  validates :name, length: {maximum: 60}, presence: true
  validates :url, presence: true

  # Responsible to find or create a sanitized repo object.
  def self.create_or_get_id(repo)
    return Repo.where(id_external: repo[:id]).first_or_create(
      id_external: repo[:id],
      name: repo[:name],
      url: repo[:url]
    ).id
  end
end
