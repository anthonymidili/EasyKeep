require 'spec_helper'

describe "companies/edit" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :company_name => "MyString",
      :address_1 => "MyString",
      :address_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :phone => "MyString",
      :fax => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", company_path(@company), "post" do
      assert_select "input#company_company_name[name=?]", "company[company_name]"
      assert_select "input#company_address_1[name=?]", "company[address_1]"
      assert_select "input#company_address_2[name=?]", "company[address_2]"
      assert_select "input#company_city[name=?]", "company[city]"
      assert_select "input#company_state[name=?]", "company[state]"
      assert_select "input#company_zip[name=?]", "company[zip]"
      assert_select "input#company_phone[name=?]", "company[phone]"
      assert_select "input#company_fax[name=?]", "company[fax]"
    end
  end
end