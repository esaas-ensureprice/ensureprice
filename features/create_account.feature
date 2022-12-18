Feature: creating an account and landing on the correct pages

  As a new patient
  So that I can access functions such as health insurance cost, finding a doctor, and writing reviews for doctors
  I want to create an account

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

Scenario: creating an account successfully, navigating the pages, and logging out
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  Then I should see the following: Welcome to the EnsurePrice App!, User1, user@gmail.com, Your Reviews, No Doctor Reviews yet...
  When I follow "Estimate Cost"
  Then I should see "Select Your Insurance Provider"
  Then I should see the following buttons: UnitedHealthCare, Oscar, Empire, Aetna, Cigna
  When I follow "Find Doctors"
  Then I should see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat 
  Then I should see "More Info" button
  When I follow "Profile"
  Then I should see the following: User1, user@gmail.com, Your Reviews, No Doctor Reviews yet...
  When I follow "Settings"
  Then I should see the following: Update Your Profile, Name, Email, Password, Confirmation
  When I follow "Log out"
  Then I should see the following: We know health insurance can be confusing, Login

Scenario: creating an account with nothing filled
  When I press "Create my account"
  Then I should see the following: The form contains 4 errors, Name can't be blank, Email can't be blank, Email is invalid, Password can't be blank

Scenario: creating an account with where the username is more than 50 characters
  When I fill in the following information: thisisoverfiftycharactersthisisoverfiftycharactersthisisoverfiftycharacters, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  Then I should see the following: The form contains 1 error, Name is too long (maximum is 50 characters)

Scenario: creating an account with incorrect email regex
  When I fill in the following information: User1, usergmail.com, 12345678, 12345678
  When I press "Create my account"
  Then I should see the following: The form contains 1 error, Email is invalid

Scenario: creating an account with an email that already exists
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  When I follow "Log out"
  When I follow "Login"
  When I follow "Sign up now!"
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"
  Then I should see the following: The form contains 1 error, Email has already been taken

Scenario: creating an account with where the password is less than 6 characters
  When I fill in the following information: User1, user@gmail.com, 12345, 12345
  When I press "Create my account"
  Then I should see the following: The form contains 1 error, Password is too short (minimum is 6 characters)

Scenario: creating an account with incorrect confirmation
  When I fill in the following information: User1, user@gmail.com, 123456, 12345
  When I press "Create my account"
  Then I should see the following: The form contains 1 error, Password confirmation doesn't match Password