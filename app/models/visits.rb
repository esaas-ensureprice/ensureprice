$types_of_visits = ['OV', 'ER', 'UC', 'SPC', 'HO']

class Visits < ActiveRecord::Base
  def self.get_visits_by_insurance_plan
    return $types_of_visits
  end
end