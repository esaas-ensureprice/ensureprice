#Steps for searching and filtering doctors and doctor reviews
When /^I select the following filters: (.*)$/ do |filter_list|
  filters = filter_list.split(', ')
  counter = 0

  filters.each do |info|
    case counter
    when 0
        steps %Q{When I select "#{info}" from "insurance_plan"}
    when 1
        steps %Q{When I select "#{info}" from "designation"}
    when 2
        steps %Q{When I select "#{info}" from "specialty"}
    else
    end
    counter += 1
  end
end

Then ("there should be {int} doctors") do |num_doctor|
    page.should have_css('div.container div.row div.card', :count == num_doctor)
end

When /^I click on Learn More for Dr. (.*)$/ do |doctor|
  found_doctor = Doctors.find_by(doctor_name: doctor)
  link = '/doctors/' + found_doctor.id.to_s
  click_link('Learn More', href: link)
end