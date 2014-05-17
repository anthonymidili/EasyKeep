class RemoveCompanyIdToTaggings < ActiveRecord::Migration
  def change
    remove_column :taggings, :company_id
  end
end
