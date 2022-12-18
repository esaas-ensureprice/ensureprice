Feature: Search for doctors based on plan, designation and specialty

  As a registered patient
  So that I can find a doctor with the desired designation and specialties that accepts my provider
  I want to filter and search for doctors after creating an account and logging in

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

  Scenario: Select nothing and see all the doctors on the find doctors page
    Then I should see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
    Then there should be 10 doctors

  Scenario: Select all the doctors on the find doctors page
    When I select the following filters: All Providers, All Designations, All Specialities
    When I press "Filter Doctors"
    Then I should see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
    Then there should be 10 doctors

  Scenario: Filter doctors based on insurance provider
    When I select the following filters: Aetna, All Designations, All Specialities
    When I press "Filter Doctors"
    Then I should see the following: Rene Mediavillo, Keyur Mehta
    Then I should not see the following: Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
    Then there should be 2 doctors

  Scenario: Filter doctors based on specialty and designation
    When I select the following filters: All Providers, Specialist, General Dentist
    When I press "Filter Doctors"
    Then I should see the following: Michael Milano, Uma Mishra
    Then I should not see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
    Then there should be 2 doctors

  Scenario: Going into individual doctor's page
    When I select the following filters: All Providers, Specialist, General Dentist
    When I press "Filter Doctors"
    When I click on More Info for Dr. Michael Milano
    Then I should see the following: Gender, Designation, Specialty, Insurance Plan, Provider Type, National Provider Identifier, Medicaid Provider Number, Phone No., Location
    Then I should see the following: Michael Milano, Specialist, General Dentist, UnitedHealthCare, MD, 1164452314, 99999999, 601 Elmwood Ave, 2752171