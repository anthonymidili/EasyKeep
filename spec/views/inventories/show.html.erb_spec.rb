require 'spec_helper'

describe "inventories/show" do
  before(:each) do
    @inventory_item = assign(:inventory_item, stub_model(InventoryItem,
      :item => "Item",
      :unit_amount => 1,
      :unit_type => "Unit Type",
      :serial_number => "Serial Number",
      :description => "Description",
      :company_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Item/)
    rendered.should match(/1/)
    rendered.should match(/Unit Type/)
    rendered.should match(/Serial Number/)
    rendered.should match(/Description/)
    rendered.should match(/2/)
  end
end
