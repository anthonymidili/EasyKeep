require 'spec_helper'

describe "accounts/edit" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :name => "MyString",
      :address_1 => "MyString",
      :address_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :phone => "MyString",
      :fax => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", account_path(@account), "post" do
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
