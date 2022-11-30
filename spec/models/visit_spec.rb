require 'rails_helper'

RSpec.describe Visit do
  describe '.get_visits_by_insurance_plan' do
    it 'gets visits by insurance plan' do
      result = Visit.get_visits_by_insurance_plan
      expect(result).to eq(['OV', 'ER', 'UC', 'SPC', 'HO'])
    end
  end
end