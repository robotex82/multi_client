class Session
  include ActiveModel::Model

  attr_accessor :tenant_id

  validates :tenant_id, presence: true
end
