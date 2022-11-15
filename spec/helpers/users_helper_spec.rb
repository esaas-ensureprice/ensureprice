require 'rails_helper'

describe UsersHelper do
  describe "gravatar_for" do
    let(:valid_attributes) {
        {
            name: "name",
            email: "email@gmail.com",
            password: "Password Digest",
            password_confirmation: "Password Digest",
        }
      }
    let!(:user) { User.create! valid_attributes }
 
    # it "should return the correct Gravatar url" do
    #   gravatar_url = "https://secure.gravatar.com/avatar/#{user.email.downcase}"
    #   expect(helper.gravatar_for(user).to eq(gravatar_url))
    # end
 
    # it "should return an image tag with the correct Gravatar url" do
    #   gravatar_url = "https://secure.gravatar.com/avatar/#{user.email.downcase}"
    #   expect(helper.gravatar_for(user)).to eq(image_tag(gravatar_url))
    # end
  end
end