class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :last_name
      t.string :first_name
      t.text :national_provider_identifier
      t.text :medicaid_provider
      t.string :site_name
      t.string :room_or_suite
      t.string :street_address
      t.string :town_city
      t.string :state
      t.string :county
      t.string :zip_code
      t.text :phone_number
      t.string :provider_type
      t.string :gender
      t.string :commercial_provider_indicator
      t.text :plan_name
      t.string :insurance_plan
      t.string :specialty
      t.string :designation
      t.string :doctor_name
      t.text :location
      t.float :avg_rating, default: 0.0
    end
  end
end
