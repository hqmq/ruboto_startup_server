require_relative '../minitest_helper'

describe "/" do
  it "shows a basic homescreen" do
    visit '/'
    asset page.has_content?("booba")
  end
end
