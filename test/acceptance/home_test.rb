require_relative '../minitest_helper'

describe "/ Acceptance Test" do
  it "shows a basic homescreen" do
    Measurement.create({
      :created_at => "2012-12-01",
      :duration => 5432,
      :package => 'org.ruboto.benchmarks',
      :package_version => '0.1.0',
      :manufacturer => 'samsung',
      :model => 'GT-I9100',
      :android_version => '4.1.1',
      :ruboto_platform_version => '0.4.9',
      :ruboto_app_version => '0.7.1',
      :test => 'Startup',
      :compile_mode => 'OFFIR',
      :ruby_version => '1_9'
    })
    visit '/'
    page.must_have_content "Ruboto"
    page.must_have_content "2012-12-01"
    page.must_have_content "org.ruboto.benchmarks"
  end
end
