# ESAAS Project: EnsurePrice

### Steps to Run

1. bundle install --without production
2. bundle exec rake db:setup
3. bundle exec rake db:migrate
4. bundle exec rake db:test:prepare
5. bundle exec rake db:seed
6. rails server 

### Creating Migration for Insurance Plans Table
```
rails generate migration CreateInsurancePlans company_name:string insurance_plan_name:text individual_annual_deductible:text ov:text er:text uc:text spc:text ho:text
```

