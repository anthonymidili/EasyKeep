require 'spec_helper'

describe "services/edit" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :amount_received => "9.99",
      :note => "MyText"
    ))
  end

  it "renders the edit service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", service_path(@service), "post" do
      assert_select "input#service_amount_received[name=?]", "service[amount_received]"
      assert_select "textarea#service_note[name=?]", "service[note]"
    end
  end
end
