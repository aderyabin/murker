require 'rails_helper'

RSpec.describe "martians/show", type: :view do
  before(:each) do
    @martian = assign(:martian, Martian.create!(
      :name => "Name",
      :age => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
