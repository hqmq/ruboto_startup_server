require_relative '../minitest_helper'

describe "/ Acceptance Test" do
  it "shows a basic homescreen" do
    visit '/'
    page.must_have_content "Ruboto"
    page.must_have_content "2012-12-01"
    page.must_have_content "org.ruboto.benchmarks"
  end
end
