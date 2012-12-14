require_relative '../minitest_helper'

describe '/measurements/top_ten Acceptance Test' do
  it "displays top performers for the various benchmarks" do
    visit '/measurements/top_ten'
    page.must_have_content "Top RubotoCore Install"
    page.must_have_content "Top Fibonacci, n=25"
    page.must_have_content "Top require json"
  end
end
