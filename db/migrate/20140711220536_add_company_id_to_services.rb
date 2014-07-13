class AddCompanyIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :company_id, :integer

    Company.all.each do |company|
      company.accounts.each do |account|
        account.services.each do |service|
          service.update_attribute(:company_id, company.id)
        end
      end
    end
  end
end
