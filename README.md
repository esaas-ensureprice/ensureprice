# ESAAS Project: Team 36

## EnsurePrice: Focus on your health, not your finances

![](app/assets/images/front_page.jpg)

## Team Members

**yk2950**: Yukti Khurana <br>
**cc4799**: Chiao Fen Chan <br>
**ml4272**: Muhan Liang <br>
**ia2422**: Isabelle Arevalo <br>

## About

- Different healthcare insurance companies have different websites and many different policies under each one of their umbrellas. It is very `hard for an individual to decipher what each policy means`, let alone to know transparently how much their potential upcoming doctor’s visit would cost.
- This leaves a hole in the market and gives us an opportunity to help healthcare insurance policy holders have peace of mind before going into their doctor’s appointment - knowing how much they will end up paying.
- Our SAAS Platform solved this problem by providing our users unbiased and `transparent cost information` about their upcoming consultation so that they don't have to spend hours on phone or internet to understand their health insurance and benefits.
- Currently our application targets users in `New York, US`. We are aiming to expand our database to other parts of US in the future.
- Our product is currently providing top plan and insurance policies from companies: `Aetna`, `Oscar`, `UnitedHealthCare`, `EmblemHealth` and `Empire`. We aim to add more companies and expand our database to include more plans in the future.

## Application Flow

- The user is taken to the home screen with a brief explanation of what our application does.
- After they click the start button, they are taken to a new page so that they can select from different insurance providers.
- After the user provides use with the company, we provide them a list of top plans that the company offers. We wanted the software to be user-friendly so we ensured that user can achieve the goal but just a few clicks and need not enter too much information.
- Once the user selects a plan that they are enrolled in, We should them a list of doctors that currently accept this plan.
- User can choose any doctor of their choice and would then be prompted to select the kind of visit they are planning or already did.
- Based on the information stored in our database we generate the estimated cost.

**_Disclaimer_**: Since the medical cost depends on a variety of factors which can differ on the case-to-case basis and the kind of treatment, our app in no way provides the exact cost of visit. Instead, our aim is to provide users with how much benefit they might receive with their current insurance plan, based on the visit. Therefore, we endeavour to demystify their health insurance.

## Implementation

To achieve this objective, we have created two tables - `Health Insurance Plans` and `Doctors`.

#### Health Insurance Plans table

It contains details of various insurance plans given by different companies and the cost benefits they provide for different types of visits like Office visit, Critical Care, Specialist Treatment and more. Even though such details are provided on the insurance cards by most companies, people rarely know what they exactly mean and how it affects their final price.
Currently, we have collected and used a small part of the data available about various insurance policies from: https://nystateofhealth.ny.gov/

#### Doctors table

It contains details of doctors and which insurance providers are accepted by them so that the user can easily choose from the list of doctors that appears after they provide us their insurance provider.
We have created a small database of Doctors in NYC for the proof of concept using: https://www.zocdoc.com/ <br>
We aim to expand this database as well by adding more options for the users.

**Note**: The csv files containing above tables to seed data can be found at `lib/seeds/doctors.csv` and `lib/seeds/health_insurance.csv`

#### User Stories

The user stories of our SAAS application can be found at `features` directory in `features/estimate_visit_cost.feature` for the most basic features in our product.

#### RSpec Tests

We have thouroughly tested our application with a coverage of 100%. Our Rspec tests can be found at `spec` directory. Further, we have used FactoryBot to create test fixtures for our software testing. <br>

Following are our test files: <br>
`spec/controllers/ensureprices_controller_spec.rb` <br>
`spec/models/doctors_spec.rb` <br>
`spec/models/insurance_plans_spec.rb` <br>
`spec/models/price_spec.rb` <br>
`spec/models/visit_spec.rb` <br>

## Deployment

Following is the Heroku Deployment Link for our product. <br>
Please make sure use Safari to open the following link: <br>
https://haunted-vault-89277.herokuapp.com/ensureprices

### Ruby Version Bundler Version & Machine OS

ruby 2.6.6p146 (2020-03-31 revision 67876) [x86_64-darwin21] <br>
MacOS <br>
to correctly install the right bundler version: <br>

```
gem uninstall bundler
```

```
gem install bundler --version '1.9'
```

## Grading For Project Iteration-1

### Branch for Grading:

proj-iter1

### TA access:

We have invited the following TAs to join organization's repo, and each TA should have received an email from GitHub regarding this. <br>
The invitation link is valid for 7 days, if the link is expired, please reach out to muhan.liang@columbia.edu to grant access. <br>
FranCao <br>
caseyolsen <br>
abeishekeeva <br>
jayshildave4096 <br>
bigapple716 <br>
yiquliu <br>
zhaoweicheng98 <br>
Airera047 <br>
etseff <br>
ZTColumbia <br>
lleizuo <br>

### Steps to Run the App

1. bundle install --without production
2. bundle exec rake db:setup
3. bundle exec rake db:migrate
4. bundle exec rake db:test:prepare
5. bundle exec rake db:seed
6. bundle exec rails server

### Steps to Run Tests

1. bundle exec rake cucumber
2. bundle exec rake spec

## Other Details

### Creating Migration for Insurance Plans Table

```
rails generate migration CreateInsurancePlans company_name:string insurance_plan_name:text individual_annual_deductible:text ov:text er:text uc:text spc:text ho:text
```

### db/seeds

If seed doesn't work: run the command for seed file to work

```
gem install csv
```

### Checking if seeding data was successful

You should get results on typing the following on Rails Console

```
InsurancePlans.find_by(insurance_plan_name:"MTRO GT 7000/100 EPO HSA 23 BRONZE NS INN DEP 25 DP FP")
```

```
Doctors.where(insurance_plan:"Oscar").where(doctor_name:"Afnan Haq").first
```

### Potential Solutions for Heroku Deployment Problem (in case you encounter)

solution to the Heroku deployment problem:

- run the following two:
  - `heroku run rake db:migrate`
  - `heroku run rake db:seed`
- change `gem 'pg'` to `gem 'pg', '~> 0.15'` in Gemfile then do `bundle install`, which will generate new Gemfile.lock file
- make sure you have `bin/` directory with files. if not, run `rake rails:update:bin`
