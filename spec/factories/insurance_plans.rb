FactoryBot.define do
  factory :insurance_plans do
    company_name { 'Provider' }
    insurance_plan_name {'Plan'}
    individual_annual_deductible {'3000'}
    ov {'30%'}
    er {'30'}
    uc {'50%'}
    spc {'100'}
    ho {'20%'}
  end
end