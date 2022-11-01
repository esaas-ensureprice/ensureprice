# ESAAS Project: Team 36
## EnsurePrice: Focus on your health, not your finances
![](app/assets/images/front_page.jpg)

## About
Different healthcare insurance companies have different websites and many different policies under each one of their umbrellas. It is very hard for an individual to decipher what each policy means, let alone to know transparently how much their potential upcoming doctor’s visit would cost. This leaves a hole in the market and gives us an opportunity to help healthcare insurance policy holders have peace of mind before going into their doctor’s appointment - knowing how much they will end up paying. Our SAAS Platform solved this problem by providing our users unbiased and transparent cost information about their upcoming consultation so that they don't have to spend hours on phone or internet to understand their health insurance and benefits.

### Team Members
Yukti Khurana yk2950 <br>
Chiao Fen Chan cc4799 <br>
Muhan Liang ml4272 <br>
Isabelle Arevalo ia2422 <br>

### Heroku Deployment Link
https://haunted-vault-89277.herokuapp.com/ensureprices

### Ruby Version & Machine OS
ruby 2.6.6p146 (2020-03-31 revision 67876) [x86_64-darwin21] <br>
MacOS

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
* run the following two:
    * `heroku run rake db:migrate`
    * `heroku run rake db:seed`
* change `gem 'pg'` to `gem 'pg', '~> 0.15'` in Gemfile then do `bundle install`, which will generate new Gemfile.lock file
* make sure you have `bin/` directory with files. if not, run `rake rails:update:bin`
