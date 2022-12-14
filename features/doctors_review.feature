Feature: Read and write doctor reviews

  As a registered patient
  So that I can find a reputable doctor
  I want to read and write doctor reviews for doctors I have visited

Background: user navigates to the create account page
  Given the following insurance plans exist:
  | company_name            | insurance_plan_name                         | individual_annual_deductible | ov  | er  | uc  | spc | ho  |
  | UnitedHealthCare        | UNITEDHEALTHCARE: SAVINGS PLUS              | 1000                         | 10  | 100 | 10  | 10  | 10% |
  | UnitedHealthCare        | UNITEDHEALTHCARE: PREMIUM PLUS              | 2000                         | 20  | 200 | 20  | 20  | 20% |
  | Oscar                   | OSCAR LIFE INSURANCE COMPANY: BROAD PPO     | 3000                         | 30% | 30% | 30% | 30% | 30% |
  | Oscar                   | OSCAR LIFE INSURANCE COMPANY: COOL PPO      | 4000                         | 40% | 40% | 40% | 30% | 30% |
  | Aetna                   | AETNA LIFE INSURANCE COMPANY: BROAD PPO     | 5000                         | 50  | 50  | 5   | 5%  | 500 |
  | Aetna                   | AETNA LIFE INSURANCE COMPANY: SAFE PPO      | 6000                         | 60  | 60  | 60  | 60% | 600 |
  | Cigna                   | CIGNA LIFE INSURANCE COMPANY: BROAD PPO     | 7000                         | 70% | 70% | 70% | 70% | 70% |
  | Cigna                   | CIGNA LIFE INSURANCE COMPANY: SAFE PPO      | 8000                         | 80% | 80% | 80% | 80% | 800 |
  | Empire                  | EMPIRE LIFE INSURANCE COMPANY: SAVINGS PLUS | 9000                         | 90  | 90  | 90  | 90  | 900 |
  | Empire                  | EMPIRE HEALTH INSURANCE COMPANY OF NEW YORK | 9999                         | 99  | 99  | 99  | 99  | 999 |

  Given the following doctors exist:
  | last_name  | first_name | national_provider_identifier | medicaid_provider | site_name                                | room_or_suite | street_address    | town_city  | state | county | zip_code | phone_number | provider_type | gender | commercial_provider_indicator | plan_name                                             | insurance_plan            | specialty                  | designation        | doctor_name     | location                                       |
  | Mediavillo | Rene       | 1376622019                   | 99999999          | Liberty Avenue                           |               | 9202 Liberty Ave  | Ozone Park | NY    | Queens | 11417    | 8359729      | MD            | M      | No                            | AETNA LIFE INSURANCE COMPANY: SAFE PPO                | Aetna                     | Pediatric Gastroenterology | Specialist         | Rene Mediavillo | 9202 Liberty Ave, Ozone Park, Queens, NY 11417 |
  | Mehta      | Keyur      | 1235339326                   | 99999999          | 3Rd Avenue                               |               | 4487 3Rd Ave      | Bronx      | NY    | Bronx  | 457      | 9606430      | MD            | M      | No                            | AETNA LIFE INSURANCE COMPANY: SAFE PPO                | Aetna                     | Pediatric Gastroenterology | Specialist         | Keyur Mehta     | 4487 3Rd Ave, Bronx, Bronx, NY 457             |
  | Meritz     | Keith      | 1801956974                   | 99999999          | Maimonides Division Of Radiation Oncolog |               | 6300 8Th Ave      | Brooklyn   | NY    | Kings  | 112      | 7652722      | MD            | M      | No                            | UNITEDHEALTHCARE: SAVINGS PLUS                        | UnitedHealthCare          | Pediatric Gastroenterology | Specialist         | Keith Meritz    | 6300 8Th Ave, Brooklyn, Kings, NY 112          |
  | Milano     | Michael    | 1164452314                   | 99999999          | Elmwood Avenue                           |               | 601 Elmwood Ave   | Rochester  | NY    | Monroe | 14642    | 2752171      | MD            | M      | No                            | UNITEDHEALTHCARE: PREMIUM PLUS                        | UnitedHealthCare          | General Dentist            | Specialist         | Michael Milano  | 601 Elmwood Ave, Rochester, Monroe, NY 14642   |
  | Mishra     | Uma        | 1003803594                   | 99999999          | U.S. Hwy. 9W                             |               | 2565 Us Hwy 9W    | Cornwall   | NY    | Orange | 12518    | 5344700      | MD            | M      | No                            | OSCAR LIFE INSURANCE COMPANY: BROAD PPO               | Oscar                     | General Dentist            | Specialist         | Uma Mishra      | 2565 Us Hwy 9W, Cornwall, Orange, NY 12518     |
  | Mix        | Michael    | 1720379233                   | 99999999          | Champlin Avenue                          |               | 1656 Champlin Ave | Utica      | NY    | Oneida | 132      | 6245260      | MD            | F      | No                            | OSCAR LIFE INSURANCE COMPANY: COOL PPO                | Oscar                     | Cardiovascular Disease     | PCP and Specialist | Michael Mix     | 1656 Champlin Ave, Utica, Oneida, NY 132       |
  | Monster    | Cookie     | 1801956986                   | 99999999          | Maimonides Division Of Radiation Oncolog |               | 6300 8Th Ave      | Brooklyn   | NY    | Kings  | 112      | 7652722      | MD            | F      | No                            | EMPIRE LIFE INSURANCE COMPANY: SAVINGS PLUS           | Empire                    | Cardiovascular Disease     | PCP and Specialist | Cookie Monster  | 6300 8Th Ave, Brooklyn, Kings, NY 112          |
  | Pepsi      | Soda       | 0064452300                   | 99999999          | Elmwood Avenue                           |               | 601 Elmwood Ave   | Rochester  | NY    | Monroe | 14642    | 2752171      | MD            | F      | No                            | EMPIRE HEALTH INSURANCE COMPANY OF NEW YORK           | Empire                    | Radiologist Oncology       | PCP                | Soda Pepsi      | 601 Elmwood Ave, Rochester, Monroe, NY 14642   |
  | Guitar     | Hero       | 2303803598                   | 99999999          | U.S. Hwy. 9W                             |               | 2565 Us Hwy 9W    | Cornwall   | NY    | Orange | 12518    | 5344700      | MD            | F      | No                            | CIGNA LIFE INSURANCE COMPANY: BROAD PPO               | Cigna                     | Radiologist Oncology       | PCP                | Hero Guitar     | 2565 Us Hwy 9W, Cornwall, Orange, NY 12518     |
  | Cat        | Kitten     | 6720379200                   | 99999999          | Champlin Avenue                          |               | 1656 Champlin Ave | Utica      | NY    | Oneida | 132      | 6245260      | MD            | F      | No                            | CIGNA LIFE INSURANCE COMPANY: SAFE PPO                | Cigna                     | Radiologist Oncology       | PCP                | Kitten Cat      | 1656 Champlin Ave, Utica, Oneida, NY 132       |                    
 
  Then 10 seed insurance plans should exist
  Then 10 seed doctors should exist

  Given I am on the Ensureprice homepage
  When I follow "Login"
  When I follow "Sign up now!"
  Then I should see "Sign Up"
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "Find Doctors"
  Then I should see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
  When I click on More Info for Dr. Kitten Cat

Scenario: Adding a review for a doctor
  When I leave a review
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."

Scenario: Adding a review for a doctor and reading from the doctor's review page
  When I leave a review
  When I select "4" from "doctor_review_rating"
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I read the reviews
  Then I should see the following: Reviews for Dr. Kitten Cat, She is a great doctor, Dr. Kitten Cat is a great doctor
  Then I should count 4 checked stars
  Then I should count 1 unchecked stars

Scenario: Add a review for a doctor and reading from the user's own profile page
  When I leave a review
  When I select "4" from "doctor_review_rating"
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Profile"
  Then I should see the following: Your Reviews, Dr. Kitten Cat, She is a great doctor, Dr. Kitten Cat is a great doctor
  Then I should count 4 checked stars
  Then I should count 1 unchecked stars

Scenario: Add review without entering anything in the text field 
  When I leave a review
  When I fill in "Title" with ""
  When I fill in "Review" with ""
  When I press "Submit Review"
  Then I should see the following: The form contains 2 error, Review title can't be blank, User review can't be blank

Scenario: Edit past review made to a doctor
  When I leave a review
  When I select "4" from "doctor_review_rating"
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Profile"
  When I edit the review for Dr. Kitten Cat
  When I select "5" from "doctor_review_rating"
  When I fill in the review: She is a wonderful doctor, Dr. Kitten Cat is a wonderful doctor
  When I press "Update My Review"
  Then I should see the following: Your Reviews, Dr. Kitten Cat, She is a wonderful doctor, Dr. Kitten Cat is a wonderful doctor
  Then I should count 5 checked stars
  Then I should count 0 unchecked stars

Scenario: Edit review without entering anything in the text field
  When I leave a review
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Profile"
  When I edit the review for Dr. Kitten Cat
  When I fill in "Title" with ""
  When I fill in "Review" with ""
  When I press "Update My Review"
  Then I should see the following: The form contains 2 error, Review title can't be blank, User review can't be blank

Scenario: Delete past review made to a doctor
  When I leave a review
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I would be on the doctors page for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Profile"
  When I delete the review for Dr. Kitten Cat
  Then I should see "Review for Dr. Kitten Cat was deleted successfully."
  Then I should not see the following: She is a great doctor, Dr. Kitten Cat is a great doctor

Scenario: Leaving multiple reviews
  When I leave a review
  When I select "1" from "doctor_review_rating"
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I leave a review
  When I select "2" from "doctor_review_rating"
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I should count 1 checked stars
  Then I should count 1 half stars
  Then I should count 3 unchecked stars

Scenario: Searching for user's own review based doctor
  When I leave a review
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Back To Doctors"
  When I click on More Info for Dr. Michael Milano
  When I leave a review
  When I select "3" from "doctor_review_rating"
  When I fill in the review: He is an average doctor, Dr. Michael Milano is an average doctor
  When I press "Submit Review"
  Then I should see "Review for Dr. Michael Milano submitted successfully."
  When I follow "Profile"
  When I fill in "query" with "Michael"
  When I press "Search"
  Then I should see the following: Michael Milano
  Then I should not see the following: Kitten Cat

Scenario: Searching for user's own review based review title
  When I leave a review
  When I fill in the review: She is a great doctor, Dr. Kitten Cat is a great doctor
  When I press "Submit Review"
  Then I should see "Review for Dr. Kitten Cat submitted successfully."
  When I follow "Back To Doctors"
  When I click on More Info for Dr. Michael Milano
  When I leave a review
  When I select "3" from "doctor_review_rating"
  When I fill in the review: He is an average doctor, Dr. Michael Milano is an average doctor
  When I press "Submit Review"
  Then I should see "Review for Dr. Michael Milano submitted successfully."
  When I follow "Profile"
  When I fill in "query" with "she is a great doctor"
  When I press "Search"
  Then I should see the following: Kitten Cat
  Then I should not see the following: Michael Milano