require 'spec_helper'

describe "inventories/edit" do
  before(:each) do
    @inventory_item = assign(:inventory_item, stub_model(InventoryItem,
      :item => "MyString",
      :unit_amount => 1,
      :unit_type => "MyString",
      :serial_number => "MyString",
      :description => "MyString",
      :company_id => 1
    ))
  end

  it "renders the edit inventory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inventory_path(@inventory_item), "post" do
      assert_select "input#inventory_item[name=?]", "inventory[item]"
      assert_select "input#inventory_unit_amount[name=?]", "inventory[unit_amount]"
      assert_select "input#inventory_unit_type[name=?]", "inventory[unit_type]"
      assert_select "input#inventory_serial_number[name=?]", "inventory[serial_number]"
      assert_select "input#inventory_description[name=?]", "inventory[description]"
      assert_select "input#inventory_company_id[name=?]", "inventory[company_id]"
    end
  end
end
