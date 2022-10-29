Feature: Estimate a doctor's visit cost 

  As a patient
  So that I can quickly find out the approximate cost of my next appointment
  I want to see the closest cost estimate taking into consideration my current insurance plan

Background: insurance plans have been added to the database

  Given the following insurance plans exist:
  | company_name            | insurance_plan_name                                              | individual_annual_deductible | ov  | er  | uc  | spc | ho 
  | UnitedHealthCare        | MTRO GT 40/75/6500/50 EPO HSA 23 BRONZE NS INN DEP 25 DP FP      | 6500                         | 40  | 500 | 80  | 75  | 50%
  | Oscar                   | Bronze $7300, INN, Circle, Dep 25, Pediatric Dental, NSD, DP, FP | 7300                         | 30% | 30% | 30% | 30% | 30%
  | Aetna                   | Aetna Medicare Assure Plan (HMO D-SNP) H3312-069                 | 8300                         | 0   | 0   |  0  |  0  |  0
  | Aetna                   | Aetna Medicare Eagle Plan (PPO) H5521-320                        | 7550                         | 0   | 95  | 60  | 35  | 395

  Given the following doctors exist:
  | insurance_plan          | doctor_name       | state | zip_code  | speciality  
  | UnitedHealthCare        | Paunel Vukasinov  | NY    | 10065     | Primary Care       
  | Oscar                   | Patricia Kennedy  | NY    | 11211     | Physician Assistant         
  | Aetna                   | Linda Wang        | NY    | 10065     | Primary Care                                 
  | Aetna                   | Luis Aybar        | NY    | 10003     | Cardiologist                       
  
  And I am on the EnsurePrice home page
  Then a dropdown for insurance provider should exist

Scenario: list all insurance providers
  When I press "Find Insurance Company" dropdown
  Then I should see the following companies: Oscar;Aetna;UnitedHealthCare
  Then I should not see the following movies: EmblemHealth;Empire

Scenario: list all insurance plans
  When I select Aetna from Insurance_Providers
  And I press "Submit"
  Then I should see the following insurance plans: Aetna Medicare Assure Plan (HMO D-SNP) H3312-069;Aetna Medicare Eagle Plan (PPO) H5521-320
  And I should not see the following insurance plans: MTRO GT 40/75/6500/50 EPO HSA 23 BRONZE NS INN DEP 25 DP FP;Bronze $7300, INN, Circle, Dep 25, Pediatric Dental, NSD, DP, FP

Scenario: list all the doctors that accept selected plan
  When I select "Aetna Medicare Assure Plan (HMO D-SNP) H3312-069" from Insurance_Plans
  And I press "Submit"
  Then I should see the following doctors: Linda Wang;Luis Aybar
  And I should not see the following doctors: Paunel Vukasinov;Patricia Kennedy

Scenario: List the visit/consultation types
  When I select "Linda Wang" from Doctors
  And I press "Submit"
  Then I should see the following visit types: OV;ER;UC;SPC;HO

Scenario: Show the estimated visit cost using insurance
  When I select "OV" from Visit_Types
  And I press "Submit"
  Then I should see the estimated price: $0 after deductible of $8300
 