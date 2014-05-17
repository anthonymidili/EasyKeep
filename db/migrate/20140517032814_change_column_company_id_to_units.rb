class ChangeColumnCompanyIdToUnits < ActiveRecord::Migration
  def change
    remove_column :units, :company_id
    add_column :units, :company_id, :integer
  end
end
