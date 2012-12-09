# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
if Rails.env.test?
  require 'csv'
  CSV.foreach( File.expand_path("db/test_fixtures.csv", Rails.root), headers: true) do |row|
    Measurement.create( row.to_hash )
  end
end
