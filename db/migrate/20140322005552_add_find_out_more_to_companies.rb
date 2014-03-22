class AddFindOutMoreToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :established_on, :date
    add_column :companies, :license_number, :string
    add_column :companies, :service_provided, :string
    add_column :companies, :service_summery, :text
  end
end
