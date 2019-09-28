class Event < ActiveRecord::Base
  # Relation
  belongs_to :actor
  belongs_to :repo

  # Validations
  validates :id_external, uniqueness: true, presence: true
  validates :event_type, length: {maximum: 30}, presence: true
  validates :created_at, presence: true

  # Responsible to truncate the event table.
  def self.clear_all
    begin
      self.delete_all
    rescue StandardError => e
      I18n.t('errors.messages.table_destroy_error')
    end
  end
end
