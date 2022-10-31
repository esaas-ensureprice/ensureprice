require 'rails_helper'

RSpec.describe Visits do
  describe '.get_visits_by_insurance_plan' do
    it 'get visits by insurance plan' do
      result = Visits.get_visits_by_insurance_plan
      expect(result).to eq(['OV', 'ER', 'UC', 'SPC', 'HO'])
    end
  end
end