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
      # to not show the movies
      steps %Q{Then I should see "#{provider}"}
    else
      # to show the given movies
      steps %Q{Then I should not see "#{provider}"}
    end
  end
end

Then /^I should (not )?see the following insurance plans: (.*)$/ do |no, plan_list|
  plans_to_show = plan_list.split(', ')
  plans_to_show.each do |plan|
    if no.nil?
      # to not show the movies
      steps %Q{Then I should see "#{plan}"}
    else
      # to show the given movies
      steps %Q{Then I should not see "#{plan}"}
    end
  end
end

Then /^I should (not )?see the following doctors: (.*)$/ do |no, doctor_list|
  doctors_to_show = doctor_list.split(', ')
  doctors_to_show.each do |doctor|
    if no.nil?
      # to not show the movies
      steps %Q{Then I should see "#{doctor}"}
    else
      # to show the given movies
      steps %Q{Then I should not see "#{doctor}"}
    end
  end
  # pending "Fill in this step in ensureprice_steps.rb"
end

Then /^I should (not )?see the following visit types: (.*)$/ do |no, visit_type_list|
  visit_types_to_show = visit_type_list.split(', ')
  visit_types_to_show.each do |visit_type|
    if no.nil?
      # to not show the movies
      steps %Q{Then I should see "#{visit_type}"}
    else
      # to show the given movies
      steps %Q{Then I should not see "#{visit_type}"}
    end
  end
  # pending "Fill in this step in ensureprice_steps.rb"
end

# Given(/^I have "([^"]*)" Insurance and I am on the Doctors page for "([^"]*)"$/) do |provider, plan|
#   session[:id] = provider
#   doctors_path(plan)
# end

