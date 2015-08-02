class Session
  include ActiveModel::Model

  attr_accessor :client_id

  validates :client_id, presence: true
end