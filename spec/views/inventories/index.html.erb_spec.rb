require 'spec_helper'

describe "inventories/index" do
  before(:each) do
    assign(:inventory_items, [
      stub_model(InventoryItem,
        :item => "Item",
        :unit_amount => 1,
        :unit_type => "Unit Type",
        :serial_number => "Serial Number",
        :description => "Description",
        :company_id => 2
      ),
      stub_model(InventoryItem,
        :item => "Item",
        :unit_amount => 1,
        :unit_type => "Unit Type",
        :serial_number => "Serial Number",
        :description => "Description",
        :company_id => 2
      )
    ])
  end

  it "renders a list of inventories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Unit Type".to_s, :count => 2
    assert_select "tr>td", :text => "Serial Number".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
