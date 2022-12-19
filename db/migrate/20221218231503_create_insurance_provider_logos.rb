class CreateInsuranceProviderLogos < ActiveRecord::Migration
  def change
    create_table :insurance_provider_logos do |t|
      t.string :company_name
      t.string :logo
    end
  end
end
