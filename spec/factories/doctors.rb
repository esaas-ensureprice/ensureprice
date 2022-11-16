FactoryBot.define do
  factory :doctors do
    last_name { 'Madden' }
    first_name { 'Jaime' }
    doctor_name { 'Jaime Madden' }
    insurance_plan { 'Aetna' }
    location { '25 Liberty Square Route 9W, Suite 1, Stony Point, Rockland, NY 9' }
    designation { 'Specialist' }
    specialty { 'Physical Therapy' }
  end
end
