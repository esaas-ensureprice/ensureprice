Feature: creating an account and landing on the correct pages

  As a new patient
  So that I can access functions such as health insurance cost, finding a doctor, and writing reviews for doctors
  I want to create an account

Background: user navigates to the create account page
  Given I am on the Ensureprice homepage
  When I follow "Login"
  When I follow "Sign up now!"
  Then I should see "Sign Up"

Scenario: creating an account successfully, navigating the pages, and logging out
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  Then I should see the following: Welcome to the EnsurePrice App!, User1, user@gmail.com, Your Reviews, You have not given any doctor reviews yet!
  When I follow "Health Insurance Cost"
  Then I should see the following: Select Your Insurance Provider, UnitedHealthCare, Oscar, Empire, Aetna, Cigna
  When I follow "Find Doctors"
  Then I should see the following: Select the Doctor that suits your needs, Dr. David Dunkin, Learn More
  When I follow "User"
  When I follow "Profile"
  Then I should see the following: User1, user@gmail.com, Your Reviews, You have not given any doctor reviews yet!
  When I follow "User"
  When I follow "Settings"
  Then I should see the following: Update your profile, Name, Email, Password, Confirmation
  When I follow "User"
  When I follow "Log out"
  Then I should see the following: We know health insurance can be confusing, Login

Scenario: creating an account with nothing filled
  When I follow "Create my account"
  Then I should see the following: The form contains 4 errors, Name can't be blank, Email can't be blank, Email is invalid, Password can't be blank

Scenario: creating an account with where the username is more than 50 characters

Scenario: creating an account with where the email is more than 255 characters

Scenario: creating an account with where the password is less than 6 characters

Scenario: creating an account with incorrect email regex

Scenario: creating an account with incorrect confirmation