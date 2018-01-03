require 'rails_helper'

RSpec.describe "martians/edit", type: :view do
  before(:each) do
    @martian = assign(:martian, Martian.create!(
      :name => "MyString",
      :age => 1
    ))
  end

  it "renders the edit martian form" do
    render

    assert_select "form[action=?][method=?]", martian_path(@martian), "post" do

      assert_select "input[name=?]", "martian[name]"

      assert_select "input[name=?]", "martian[age]"
    end
  end
end
