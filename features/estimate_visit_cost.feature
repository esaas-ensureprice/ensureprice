Feature: Estimate a doctor's visit cost 

  As a patient
  So that I can quickly find out the approximate cost of my next appointment
  I want to see the closest cost estimate taking into consideration my current insurance plan

Background: insurance plans have been added to the database

  Given the following insurance plans exist:
  | company_name            | insurance_plan_name                                              | individual_annual_deductible | ov  | er  | uc  | spc | ho 
  | UnitedHealthCare        | MTRO GT 40/80/3250/60 EPO 23 SILVER NS INN DEP 25 DP FP          | 6500                         | 40  | 500 | 80  | 75  | 50%
  | Oscar                   | BRONZE 7300 INN CIRCLE DEP 25 PEDIATRIC DENTAL NSD DP FP         | 7300                         | 30% | 30% | 30% | 30% | 30%
  | Aetna                   | AETNA MEDICARE ASSURE PLAN HMO D-SNP H3312-069                   | 8300                         | 0   | 0   |  0  |  0  |  0
  | Aetna                   | AETNA MEDICARE EAGLE PLAN PPO H5521-320                          | 7550                         | 0   | 95  | 60  | 35  | 395

  Given the following doctors exist:
  | insurance_plan          | doctor_name       | state | zip_code  | speciality  
  | UnitedHealthCare        | Paunel Vukasinov  | NY    | 10065     | Primary Care       
  | Oscar                   | Patricia Kennedy  | NY    | 11211     | Physician Assistant         
  | Aetna                   | Linda Wang        | NY    | 10065     | Primary Care                                 
  | Aetna                   | Luis Aybar        | NY    | 10003     | Cardiologist                       
  
  And I am on the Ensureprice home page
  Then 4 seed insurance plans should exist
  Then 4 seed doctors should exist

Scenario: list all insurance providers
  When I follow "Start" 
  Then I should see the following insurance providers: Oscar, Aetna, UnitedHealthCare
  Then I should not see the following insurance providers: EmblemHealth, Empire

Scenario: list all insurance plans given the insurance providers
  Given I am on the Insurance Providers page
  When I follow "Aetna"
  Then I should see the following insurance plans: AETNA MEDICARE ASSURE PLAN HMO D-SNP H3312-069, AETNA MEDICARE EAGLE PLAN PPO H5521-320
  Then I should not see the following insurance plans: MTRO GT 40/80/3250/60 EPO 23 SILVER NS INN DEP 25 DP FP, BRONZE 7300 INN CIRCLE DEP 25 PEDIATRIC DENTAL NSD DP FP

Scenario: list all the doctors that accept selected plan
  Given I am on the Insurance Plans page for "Aetna"
  When I follow "AETNA MEDICARE ASSURE PLAN HMO D-SNP H3312-069"
  Then I should see the following doctors: Linda Wang, Luis Aybar
  Then I should not see the following doctors: Paunel Vukasinov, Patricia Kennedy

Scenario: list all the visit types for insurance after selecting the doctor
  Given I am on the Insurance Plans page for "Aetna"
  When I follow "AETNA MEDICARE ASSURE PLAN HMO D-SNP H3312-069"
  When I follow "Linda Wang"
  Then I should see the following visit types: OV, ER, UC, SPC, HO

Scenario: Show the estimated visit cost using insurance
  Given I am on the Insurance Plans page for "Aetna"
  When I follow "AETNA MEDICARE ASSURE PLAN HMO D-SNP H3312-069"
  When I follow "Linda Wang"
  When I follow "OV"
  Then I should see the estimated price: After paying your insurance deductible of $ 8300, Your Estimated Upcoming Cost Is $	0

Scenario: Show the estimated visit cost using insurance
  Given I am on the Insurance Plans page for "Oscar"
  When I follow "BRONZE 7300 INN CIRCLE DEP 25 PEDIATRIC DENTAL NSD DP FP"
  When I follow "Patricia Kennedy"
  When I follow "OV"
  Then I should see the estimated price: After paying your insurance deductible of $ 7300, Your Estimated Upcoming Cost Is	30% of the Total Bill
