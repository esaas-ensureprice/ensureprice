Feature: Estimate a doctor's visit cost 

  As a patient
  So that I can quickly find out the approximate cost of my next appointment
  I want to see the closest cost estimate taking into consideration my current insurance plan

Background: the insurance plans and doctors tables have been seeded and user creates account
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
  
  Given the following insurance provider logos exist:
  | company_name            | logo                                                                                                              |
  | UnitedHealthCare        | https://1000logos.net/wp-content/uploads/2018/02/unitedhealthcare-emblem.png                                      | 
  | Oscar                   | https://images.ctfassets.net/plyq12u1bv8a/774dmeq8GhbIb3WgvOZSJ1/a50a8f2ab73af9d96560fb616135478f/IMG_Tout_1.png  |
  | Empire                  | https://images.medaviebc.ca/plans/_1200x630_crop_center-center_none/bcbs-icon.png                                 |
  | Aetna                   | https://www.aetnainternational.com/content/dam/aetna/images/icons/1_Aetna_StorytellingIcon_Caring_Violet.png      | 
  | Cigna                   | https://logos-world.net/wp-content/uploads/2022/03/Cigna-Symbol.png                                               |
  
  Then 10 seed insurance plans should exist
  Then 10 seed doctors should exist
  Then 5 seed insurance provider logos should exist

  Given I am on the Ensureprice homepage
  When I follow "Login"
  When I follow "Sign up now!"
  Then I should see "Sign Up"
  When I fill in the following information: User1, user@gmail.com, 12345678, 12345678
  When I press "Create my account"

Scenario: list all insurance providers
  When I follow "Estimate Cost" 
  Then I should see the following buttons: UnitedHealthCare, Oscar, Empire, Aetna, Cigna
  Then I should not see the following buttons: EmblemHealth

Scenario: list all insurance plans given the insurance providers
  When I follow "Estimate Cost" 
  When I press "Aetna"
  Then I should see the following buttons: AETNA LIFE INSURANCE COMPANY: BROAD PPO, AETNA LIFE INSURANCE COMPANY: SAFE PPO
  Then I should not see the following buttons: UNITEDHEALTHCARE: SAVINGS PLUS, CIGNA LIFE INSURANCE COMPANY: SAFE PPO

Scenario: list all the doctors that accept selected plan
  When I follow "Estimate Cost" 
  When I press "Aetna"
  When I press "AETNA LIFE INSURANCE COMPANY: SAFE PPO"
  Then I should see the following buttons: OV, ER, UC, SPC, HO

Scenario: Show the estimated visit cost using copay
  When I follow "Estimate Cost" 
  When I press "Aetna"
  When I press "AETNA LIFE INSURANCE COMPANY: SAFE PPO"
  When I press "OV"
  Then I should see the estimated price: After paying your insurance deductible of $ 6000, Your Estimated Upcoming Cost Is $ 0
  Then I should see the following: Rene Mediavillo, Keyur Mehta
  Then I should not see the following: Soda Pepsi, Kitten Cat

Scenario: Show the estimated visit cost using coinsurance
  When I follow "Estimate Cost" 
  When I press "Cigna"
  When I press "CIGNA LIFE INSURANCE COMPANY: BROAD PPO"
  When I press "HO"
  Then I should see the estimated price: After paying your insurance deductible of $ 7000, Your Estimated Upcoming Cost Is 70% of the Total Bill
  Then I should see the following: Kitten Cat, Hero Guitar
  Then I should not see the following: Rene Mediavillo, Keyur Mehta
  When I fill in "query" with "Kitten"
  When I press "Search"
  Then I should see the following: Kitten Cat
  Then I should not see the following: Hero Guitar

Scenario: Search for doctors in network
  When I follow "Estimate Cost" 
  When I press "Cigna"
  When I press "CIGNA LIFE INSURANCE COMPANY: BROAD PPO"
  When I press "HO"
  Then I should see the estimated price: After paying your insurance deductible of $ 7000, Your Estimated Upcoming Cost Is 70% of the Total Bill
  Then I should see the following: Kitten Cat, Hero Guitar
  Then I should not see the following: Rene Mediavillo, Keyur Mehta
  When I go for more doctors
  Then I should see the following: Rene Mediavillo, Keyur Mehta, Keith Meritz, Michael Milano, Uma Mishra, Michael Mix, Cookie Monster, Soda Pepsi, Hero Guitar, Kitten Cat
  Then there should be 10 doctors
