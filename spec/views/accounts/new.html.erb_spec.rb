require 'spec_helper'

describe "accounts/new" do
  before(:each) do
    assign(:account, stub_model(Account,
      :name => "MyString",
      :address_1 => "MyString",
      :address_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :phone => "MyString",
      :fax => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accounts_path, "post" do
      assert_select "input#account_name[name=?]", "account[name]"
      assert_select "input#account_address_1[name=?]", "account[address_1]"
      assert_select "input#account_address_2[name=?]", "account[address_2]"
      assert_select "input#account_city[name=?]", "account[city]"
      assert_select "input#account_state[name=?]", "account[state]"
      assert_select "input#account_zip[name=?]", "account[zip]"
      assert_select "input#account_phone[name=?]", "account[phone]"
      assert_select "input#account_fax[name=?]", "account[fax]"
      assert_select "input#account_email[name=?]", "account[email]"
    end
  end
end
