require 'rails_helper'

RSpec.describe User do
  describe '.get_username' do
    it 'gets username by id' do
      user = FactoryBot.create(:user, name: "Yukti Khurana", email: 'yk2950@columbia.edu')
      result = User.get_username(user.id)
      expect(result).to eq(user.name)
    end
  end
end