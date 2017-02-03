module MultiClient
  class Client < ActiveRecord::Base
    validates :identifier, presence: true,
                           uniqueness: true

    validates :subdomain, presence: true,
                          uniqueness: true

    scope :enabled, -> { where(enabled: true) }

    def self.master
      where(identifier: Configuration.master_client_identifier).first
    end

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

    def self.set_current_by_subdomain(subdomain)
      self.current_id = where(subdomain: subdomain).first.try(:id)
    end

    def self.unset_current
      self.current_id = nil
    end

    def self.with_client(client, &block)
      original_id = current_id
      begin
        self.current_id = client.id
        Rails.logger.info "Temporarily set client id to #{client.id}"
        block.call
      rescue
        raise
      ensure
        Rails.logger.info "Restored client id to #{original_id}"
        self.current_id = original_id
      end
    end

    def self.master?
      !!(current && current.identifier == Configuration.master_client_identifier)
    end

    def self.set_current_to_master
      set_current_by_identifier(Configuration.master_client_identifier)
    end

  end
end
