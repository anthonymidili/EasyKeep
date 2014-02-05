class AddIsACompanyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :is_a_company, :boolean

    Account.all.each do |account|
      account.update_attribute(:is_a_company, true)
    end
  end
end
