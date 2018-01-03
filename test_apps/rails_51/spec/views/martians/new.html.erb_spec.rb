require 'rails_helper'

RSpec.describe "martians/new", type: :view do
  before(:each) do
    assign(:martian, Martian.new(
      :name => "MyString",
      :age => 1
    ))
  end

  it "renders new martian form" do
    render

    assert_select "form[action=?][method=?]", martians_path, "post" do

      assert_select "input[name=?]", "martian[name]"

      assert_select "input[name=?]", "martian[age]"
    end
  end
end
