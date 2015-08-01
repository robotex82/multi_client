Rails.application.routes.draw do

  mount MultiClient::Engine => "/multi_client"
end
