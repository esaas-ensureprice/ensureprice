#Steps for the EnsurePrice website in general
When /^I visit the doctor reviews show page$/ do
  visit '/doctor_reviews/1'
end

When /^I should (not )?see the following: (.*)$/ do |no, content_list|
  contents = content_list.split(', ')
  contents.each do |content|
    if no.nil?
      steps %Q{Then I should see "#{content}"}
    else
      steps %Q{Then I should not see "#{content}"}
    end
  end
end

Then /^I should (not )?see "([^"]*)" button/ do |no, name|
  if no.nil?
    first(:button, name).should_not be_nil
  else
    first(:button, name).should be_nil
  end
end

When /^I should (not )?see the following buttons: (.*)$/ do |no, button_list|
  buttons = button_list.split(', ')
  buttons.each do |button|
    if no.nil?
      steps %Q{Then I should see "#{button}" button}
    else
      steps %Q{Then I should not see "#{button}" button}
    end
  end
end

When /^I select Dr. (.*)$/ do |doctor|
  mod = doctor.sub! ' ', '%20'
  concat_link = "/visits/" + mod
  click_link('Select', href: concat_link)
end

Given /the following insurance plans exist/ do |insurance_plans_table|
  insurance_plans_table.hashes.each do |plan|
    InsurancePlans.create plan
  end
end

Given /the following doctors exist/ do |doctors_table|
  doctors_table.hashes.each do |doctor|
    Doctors.create doctor
  end
end

Then /(.*) seed insurance plans should exist/ do | n_seeds |
  expect(Doctors.count).to eq n_seeds.to_i
end

Then /(.*) seed doctors should exist/ do | n_seeds |
  expect(Doctors.count).to eq n_seeds.to_i
end

Then /^I should (not )?see the following insurance providers: (.*)$/ do |no, provider_list|
  providers_to_show = provider_list.split(', ')
  providers_to_show.each do |provider|
    if no.nil?
      # to not show the insurance providers
      steps %Q{Then I should see "#{provider}"}
    else
      # to show the given insurance providers
      steps %Q{Then I should not see "#{provider}"}
    end
  end
end

Then /^I should (not )?see the following insurance plans: (.*)$/ do |no, plan_list|
  plans_to_show = plan_list.split(', ')
  plans_to_show.each do |plan|
    if no.nil?
      # to not show the insurance plans
      steps %Q{Then I should see "#{plan}"}
    else
      # to show the given insurance plans
      steps %Q{Then I should not see "#{plan}"}
    end
  end
end

Then /^I should (not )?see the following doctors: (.*)$/ do |no, doctor_list|
  doctors_to_show = doctor_list.split(', ')
  doctors_to_show.each do |doctor|
    if no.nil?
      # to not show the doctors
      steps %Q{Then I should see "#{doctor}"}
    else
      # to show the given doctors
      steps %Q{Then I should not see "#{doctor}"}
    end
  end
end

Then /^I should (not )?see the following visit types: (.*)$/ do |no, visit_type_list|
  visit_types_to_show = visit_type_list.split(', ')
  visit_types_to_show.each do |visit_type|
    if no.nil?
      # to not show the visit type
      steps %Q{Then I should see "#{visit_type}"}
    else
      # to show the given visit type
      steps %Q{Then I should not see "#{visit_type}"}
    end
  end
end

Then("I should see the estimated price: After paying your insurance deductible of $ {int}, Your Estimated Upcoming Cost Is $ {int}") do |deductible, price|
  steps %Q{Then I should see "#{deductible}"}
  steps %Q{Then I should see "#{price}"}
end

Then("I should see the estimated price: After paying your insurance deductible of $ {int}, Your Estimated Upcoming Cost Is {int}% of the Total Bill") do |deductible, coinsurance|
  steps %Q{Then I should see "#{deductible}"}
  steps %Q{Then I should see "#{coinsurance}"}
end


