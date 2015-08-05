class AddTenantIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tenant_id, :integer, index: true, foreign_key: true
  end
end
