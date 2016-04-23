module MultiClient
  class Client < ActiveRecord::Base
    validates :identifier, presence: true,
                           uniqueness: true

    validates :subdomain, presence: true,
                          uniqueness: true

    scope :enabled, -> { where(enabled: true) }

    def self.master
      where(identifier: Configuration.master_tenant_identifier).first
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

    def self.unset_current
      self.current_id = nil
    end

    def self.with_tenant(tenant, &block)
      original_id = current_id
      begin
        self.current_id = tenant.id
        Rails.logger.info "Temporarily set tenant id to #{tenant.id}"
        block.call
      rescue
        raise
      ensure
        Rails.logger.info "Restored tenant id to #{original_id}"
        self.current_id = original_id
      end
    end

    def self.master?
      !!(current && current.identifier == Configuration.master_tenant_identifier)
    end

    def self.set_current_to_master
      set_current_by_identifier(Configuration.master_tenant_identifier)
    end

  end
end
