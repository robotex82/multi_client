class Post < ActiveRecord::Base
  include MultiClient::ModelWithClient

  validates :title, presence: true
end
