require 'rails_helper'

describe UsersHelper do
  describe "#gravatar_for" do
    let!(:user) { FactoryBot.create(:user) }

    it 'returns an img tag with the gravatar url' do
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      expect(gravatar_for(user, "gravatar")).to match(/<img/)
      expect(gravatar_for(user, "gravatar")).to match(/src=['"]#{gravatar_url}['"]/)
      expect(gravatar_for(user, "gravatar")).to match(/alt=['"]#{user.name}['"]/)
      expect(gravatar_for(user, "gravatar")).to match(/class=['"]gravatar['"]/)
    end
  end
end
