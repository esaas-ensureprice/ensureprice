class Price < ActiveRecord::Base
  def self.get_price_by_insurance_plan insurance_plan, visit_type
    if visit_type == "OV"
      return InsurancePlans.where(insurance_plan_name: insurance_plan).first.ov
    elsif visit_type == "ER"
      return InsurancePlans.where(insurance_plan_name: insurance_plan).first.er
    elsif visit_type == "UC"
      return InsurancePlans.where(insurance_plan_name: insurance_plan).first.uc
    elsif visit_type == "SPC"
      return InsurancePlans.where(insurance_plan_name: insurance_plan).first.spc
    elsif visit_type == "HO"
      return InsurancePlans.where(insurance_plan_name: insurance_plan).first.ho
    end
  end
end