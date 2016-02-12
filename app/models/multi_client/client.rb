module MultiClient
  class Client < ActiveRecord::Base
    validates :identifier, presence: true,
                           uniqueness: true

    validates :subdomain, presence: true,
                          uniqueness: true

    scope :enabled, -> { where(enabled: true) }

    def self.current_id=(id)
      Thread.current[:client_id] = id
    end

    def self.current_id
      Thread.current[:client_id]
    end

    def self.current
      enabled.where(id: Thread.current[:client_id]).first
    end

    def human
      identifier
    end

    def self.set_current_by_identifier(identifier)
      self.current_id = where(identifier: identifier).first.try(:id)
    end

    def self.unset_current
      self.current_id = nil
    end
  end
end
