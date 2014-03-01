class AddCompanyIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :company_id, :integer

    Company.all.each do |company|
      company.accounts.each do |account|
        account.invoices.each do |invoice|
          invoice.update_attribute(:company_id, company.id)
        end
      end
    end
  end
end
