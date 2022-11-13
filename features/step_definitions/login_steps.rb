#Steps for logging in and creating account
When /^I fill in the following information: (.*)$/ do |fill_list|
  info_to_fill = fill_list.split(', ')
  counter = 0

  info_to_fill.each do |info|
    case counter
    when 0
        steps %Q{When I fill in "Name" with "#{info}"}
    when 1
        steps %Q{When I fill in "Email" with "#{info}"}
    when 2
        steps %Q{When I fill in "Password" with "#{info}"}
    when 3
        steps %Q{When I fill in "Confirmation" with "#{info}"}
    else
    end
    counter += 1
  end
end