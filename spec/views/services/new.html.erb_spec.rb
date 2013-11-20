require 'spec_helper'

describe "services/new" do
  before(:each) do
    assign(:service, stub_model(Service,
      :amount_received => "9.99",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", services_path, "post" do
      assert_select "input#service_amount_received[name=?]", "service[amount_received]"
      assert_select "textarea#service_note[name=?]", "service[note]"
    end
  end
end
