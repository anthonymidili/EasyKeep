class AddCompanyIdNumberIndexToInvoices < ActiveRecord::Migration
  def change
    add_index(:invoices, [:company_id, :number], unique: true)
  end
end
