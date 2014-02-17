class AddIdsToPayments < ActiveRecord::Migration
  def up
    add_column :payments, :account_id, :integer
    add_column :payments, :company_id, :integer

    Company.all.each do |company|
      company.accounts.each do |account|
        account.invoices.each do |invoice|
          invoice.payments.each do |payment|
            payment.update_attribute(:company_id, company.id)
            payment.update_attribute(:account_id, account.id)
          end
        end
      end
    end
  end

  def down
    remove_column :payments, :account_id
    remove_column :payments, :company_id
  end
end
