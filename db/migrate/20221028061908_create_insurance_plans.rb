class CreateInsurancePlans < ActiveRecord::Migration
  def change
    create_table :insurance_plans do |t|
      t.string :company_name
      t.text :insurance_plan_name
      t.text :individual_annual_deductible
      t.text :ov
      t.text :er
      t.text :uc
      t.text :spc
      t.text :ho
    end
  end
end
