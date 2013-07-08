class RemoveAdminIdToCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :admin_id
    add_column :users, :company_id, :integer
  end
end
