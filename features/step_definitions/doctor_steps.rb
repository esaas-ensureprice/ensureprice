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

When /^I click on More Info for Dr. (.*)$/ do |doctor|
  found_doctor = Doctor.find_by(doctor_name: doctor)
  link = '/doctors/' + found_doctor.id.to_s
  click_link('More Info', href: link)
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
  found_doctor = Doctor.find_by(doctor_name: doctor)
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

When /^I edit the review for Dr. (.*)$/ do |doctor|
  found_doctor = DoctorReview.find_by(doctor_name: doctor)
  link = '/doctor_reviews/' + found_doctor.id.to_s + '/edit'
  click_link('Edit', href: link)
end

When /^I delete the review for Dr. (.*)$/ do |doctor|
  found_doctor = DoctorReview.find_by(doctor_name: doctor)
  link = '/doctor_reviews/' + found_doctor.id.to_s
  click_link('Delete', href: link)
end

Then /^I should count (.*) (.*) stars$/ do |expected_count,star_type|
  if star_type == "half"
    class_name = "fa.fa-star-half-o.checked"
  elsif star_type == "unchecked"
    class_name = "fa.fa-star.unchecked"
  else
    class_name = "fa.fa-star.checked"
  end
  
  star_count = page.all("span.#{class_name}").size
  expect(star_count).to eq(expected_count.to_i)
end

When /^I sort the doctors/ do
  click_link('Sort by Rating', href: '/doctors?sort=avg_rating')
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page).to have_content(/#{e1}(.*)#{e2}/)
end

