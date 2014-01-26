require 'spec_helper'

describe "payments/new" do
  before(:each) do
    assign(:payment, stub_model(Payment,
      :type => "",
      :amount => "9.99",
      :invoice_id => 1
    ).as_new_record)
  end

  it "renders new payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", payments_path, "post" do
      assert_select "input#payment_type[name=?]", "payment[type]"
      assert_select "input#payment_amount[name=?]", "payment[amount]"
      assert_select "input#payment_invoice_id[name=?]", "payment[invoice_id]"
    end
  end
end
