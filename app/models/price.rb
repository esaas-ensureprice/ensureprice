class Price < ActiveRecord::Base
  def self.isCoinsurance price
    return price.include? "%" 
  end

  def self.get_price_by_insurance_plan insurance_plan, visit_type
    insurance_plan_by_name = InsurancePlans.where(insurance_plan_name: insurance_plan)
    visit_type.downcase!
    insurance_record= insurance_plan_by_name
    price = insurance_record.pluck(visit_type)[0]
    deductible = insurance_record.pluck(:individual_annual_deductible)[0]
    return price, deductible
  end
end