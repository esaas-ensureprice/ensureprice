class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :insurance_plan
      t.string :doctor_name
      t.string :state
      t.text :zip_code
      t.text :speciality
    end
  end
end
