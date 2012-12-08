require_relative '../minitest_helper'

describe "/ Acceptance Test" do
  it "shows a basic homescreen" do
    visit '/'
    page.must_have_content "Ruboto"
  end
end
