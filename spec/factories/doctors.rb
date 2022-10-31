FactoryBot.define do
    factory :doctors do
      insurance_plan { 'Test Insurance Plan' }
      doctor_name {'Test Doctor Name'}
      state {'NY'}
      zip_code {'10020'}
      speciality {'Primary Care'}
    end
  end
