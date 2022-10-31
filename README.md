# ESAAS Project: EnsurePrice

### Steps to Run

1. bundle install --without production
2. bundle exec rake db:setup
3. bundle exec rake db:migrate
4. bundle exec rake db:test:prepare
5. bundle exec rake db:seed
6. bundle exec rails server 

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

