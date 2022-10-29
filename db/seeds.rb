# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Filling insurance plans table with data
require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'health_insurance.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	InsurancePlans.create!(row.to_hash)
end
puts "Insurance Plans Table has been filled with data successfully"


# Filling doctors table with data
require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'doctors.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	Doctors.create!(row.to_hash)
end
puts "Doctors Table has been filled with data successfully"

