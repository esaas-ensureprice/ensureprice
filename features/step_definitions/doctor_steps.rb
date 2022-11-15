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

When /^I fill in the review: (.*)$/ do |fill_list|
  info_to_fill = fill_list.split(', ')
  counter = 0

  info_to_fill.each do |info|
    case counter
    when 0
        steps %Q{When I fill in "Title" with "#{info}"}
    when 1
        steps %Q{When I fill in "Review" with "#{info}"}
    else
    end
    counter += 1
  end
end

Then /^I would be on the doctors page for Dr. (.*)$/ do |doctor|
  found_doctor = Doctors.find_by(doctor_name: doctor)
  link = '/doctors/' + found_doctor.id.to_s
  current_path = URI.parse(current_url).path
  current_path.should == link
end

When /^I leave a review/ do
  click_link('Add a Review', href: '/doctor_reviews/new')
end

When /^I read the reviews/ do
  click_link('See Reviews', href: '/reviews')
end
