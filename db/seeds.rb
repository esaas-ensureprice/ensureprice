# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Filling the users table for signup and login
# users = [{:username=> 'yukti', :password => 'password'},]
# users.each do |user|
#   User.create!(user)
# end

# Filling the insurance logos table with data
logos = [
	{:company_name=> 'UnitedHealthCare', :logo => 'https://1000logos.net/wp-content/uploads/2018/02/unitedhealthcare-emblem.png'},
	{:company_name=> 'Oscar', :logo => 'https://images.ctfassets.net/plyq12u1bv8a/774dmeq8GhbIb3WgvOZSJ1/a50a8f2ab73af9d96560fb616135478f/IMG_Tout_1.png'},
	{:company_name=> 'Empire', :logo => 'https://images.medaviebc.ca/plans/_1200x630_crop_center-center_none/bcbs-icon.png'},
	{:company_name=> 'Aetna', :logo => 'https://www.aetnainternational.com/content/dam/aetna/images/icons/1_Aetna_StorytellingIcon_Caring_Violet.png'},
	{:company_name=> 'Cigna', :logo => 'https://logos-world.net/wp-content/uploads/2022/03/Cigna-Symbol.png'}
]

logos.each do |logo|
	InsuranceProviderLogo.create!(logo)
end

# Filling insurance plans table with data
require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'health_insurance_new.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	InsurancePlan.create!(row.to_hash)
end
puts "Insurance Plans Table has been filled with data successfully"


# Filling doctors table with data
require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'small_doctors.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
cnt = 0
csv.each do |row|
	if cnt%100==0
		puts(cnt)
		puts(" rows added to Doctors table")
	end
	Doctor.create!(row.to_hash)
	cnt+=1
end
puts "Doctors Table has been filled with data successfully"

