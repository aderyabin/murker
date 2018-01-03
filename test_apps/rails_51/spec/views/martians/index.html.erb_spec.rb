require 'rails_helper'

RSpec.describe "martians/index", type: :view do
  before(:each) do
    assign(:martians, [
      Martian.create!(
        :name => "Name",
        :age => 2
      ),
      Martian.create!(
        :name => "Name",
        :age => 2
      )
    ])
  end

  it "renders a list of martians" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
