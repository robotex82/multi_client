module MultiClient
  class Client < ActiveRecord::Base
    validates :identifier, presence: true,
                           uniqueness: true

    validates :subdomain, presence: true,
                          uniqueness: true

    def self.current_id=(id)
      Thread.current[:client_id] = id
    end

    def self.current_id
      Thread.current[:client_id]
    end

    def human
      identifier
    end
  end
end
