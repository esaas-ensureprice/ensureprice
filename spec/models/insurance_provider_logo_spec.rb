require 'rails_helper'

RSpec.describe InsuranceProviderLogo do
  describe '.get_logo_url' do
    it 'gets insurance provider logos by provider' do
      insurance_plan1 = FactoryBot.create(:insurance_plan, company_name: 'Aetna')
      provider_logo = FactoryBot.create(:insurance_provider_logo)
      result = InsuranceProviderLogo.get_logo_url(insurance_plan1.company_name)
      expect(result).to eq(provider_logo.logo)
    end
  end
end