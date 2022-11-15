Feature: gaining access of health insurance and doctor pages without logging in

  As a lazy patient
  So that I can access functions on ensureprice
  I want to navigate to the pages without creating an account

Scenario: navigating to the health insurance cost page
  Given I am on the Ensureprice homepage
  When I follow "Health Insurance Cost"
  Then I should see "Please log in"
  Then I should not see "Select Your Insurance Provider"

Scenario: navigating to the find doctors page
  Given I am on the Ensureprice homepage
  When I follow "Find Doctors"
  Then I should see "Please log in"
  Then I should not see "Select the Doctor that suits your needs"

Scenario: navigating to the individual doctor's page
  Given I am on the Ensureprice homepage
  When I try to go to the URL "/doctors/1"
  Then I should see "Please log in"
  Then I should not see "Specialty"

Scenario: navigating to the reviews page
  Given I am on the Ensureprice homepage
  When I try to go to the URL "/reviews"
  Then I should see "Please log in"
  Then I should not see "Reviews"

Scenario: navigating to the about page
  Given I am on the Ensureprice homepage
  When I follow "About"
  Then I should see the following: About EnsurePrice


