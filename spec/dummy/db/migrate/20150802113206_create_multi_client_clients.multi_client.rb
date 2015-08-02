# This migration comes from multi_client (originally 20150801120306)
class CreateMultiClientClients < ActiveRecord::Migration
  def change
    create_table :multi_client_clients do |t|
      t.string :identifier, null: false
      t.string :subdomain, null: false
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
