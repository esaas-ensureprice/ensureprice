# ESAAS Project: Team 36
## EnsurePrice: Focus on your health, not your finances
## About
Different healthcare insurance companies have different websites and many different policies under each one of their umbrellas. It is very hard for an individual to decipher what each policy means, let alone to know transparently how much their potential upcoming doctor’s visit would cost. This leaves a hole in the market and gives us an opportunity to help healthcare insurance policy holders have peace of mind before going into their doctor’s appointment - knowing how much they will end up paying. Our SAAS Platform solved this problem by providing our users unbiased and transparent cost information about how much their upcoming consultation so that they don't have to spend hours on phone or internet to understand their health insurance and benefits.

### Team Members
Yukti Khurana yk2950 <br>
Chiao Fen Chan cc4799 <br>
Muhan Liang ml4272 <br>
Isabelle Arevalo ia2422 <br>

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

